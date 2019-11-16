# Oracle JDBC java 反射通用查询与插入数据，小白都能看的懂！！

## 1.jdbc的封装

~~~java
package util;
import java.sql.*;
public class JDBCUtil {
    public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    public static final String USERNAME = "scott";
    public static final String PASSWORD = "tiger";
    //初始化连接
    static{
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    /*
     *
     * @Description
     * @Date 18:45 2019/11/12
     * @Param
     * @return
     * 获得connection
     **/
    public static Connection getConnection()  {
        try {
            return DriverManager.getConnection(URL,USERNAME,PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
        }
            return null;
    }
    /*
     * @Author chengpunan
     * @Description
     * @Date 18:47 2019/11/12
     * @Param [connection, statement]
     * @return void
     * 关闭连接 connection和statement
     **/
    public static void closeConnection(Connection connection, Statement statement){
        if(statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(connection != null){
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    /*
     * @Author chengpunan
     * @Description
     * @Date 18:47 2019/11/12
     * @Param
     * @return
     * 关闭连接 connection和statement和resultSet
     **/

    public static void closeConnection(Connection connection, Statement statement, ResultSet resultSet){
       if(resultSet != null){
           try {
               resultSet.close();
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
        if(connection != null){
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
~~~

## 2.反射通用查询，中间插入了许多输出代码，方便了解值的类型

需求：要查询N张表的数据，但是不想写N多的方法，能否写一个方法完成所有表的查询工作。

~~~java
  //获得set方法名
    public String getSetName(String name){
        return "set"+name.substring(0,1).toUpperCase()+name.substring(1);
    }
   /*
    *sql  SQL语句
    *params  设置的参数
    *clazz  某个表，也就是对象
    */

@Override
    public List getRows(String sql, Object[] params, Class clazz) {
        List list = new ArrayList();
        Connection connection = null;
        PreparedStatement pstem = null;
        ResultSet resultSet =null;

        try {
            connection=JDBCUtil.getConnection();
            pstem = connection.prepareStatement(sql);
            //设置参数 pstem
            if(params !=  null){
                for (int i = 0; i <params.length ; i++) {
                    pstem.setObject(i+1,params[i]);
                }
            }
            resultSet = pstem.executeQuery();
            //返回元数据
            ResultSetMetaData metaData = resultSet.getMetaData();
            //查询每一行中包含多少列
            int count = metaData.getColumnCount();
            while (resultSet.next()){
                //创建对象
                Object obj = clazz.newInstance();
                for (int i = 0; i <count ; i++) {
                    //从集合中获取但一列的值
                    Object objValue = resultSet.getObject(i + 1);
//                    System.out.println("objValus是："+objValue);
                    //获取列名
                    String columnName = metaData.getColumnName(i + 1).toLowerCase();
//                    System.out.println("columnName是："+columnName);
                    //获取属性名字
                    Field declaredField = clazz.getDeclaredField(columnName);
//                    System.out.println("declaredField是："+declaredField);
                    //获得类中的 set方法，调用了上面的获取set的方法
                    Method method = clazz.getMethod(getSetName(columnName), declaredField.getType());
                    if(objValue instanceof Number){
           //转成Number是应为java的数值不能直接用在Oracle中             
                        Number number = (Number) objValue;
//                        System.out.println("number------>"+number);
                        String fname = declaredField.getType().getName();
//                        System.out.println("fname------>"+fname);
                        if("int".equals(fname) || "java.lang.Integer".equals(fname)){
                            method.invoke(obj,number.intValue());
                        }else if("byte".equals(fname)||"java.lang.Byte".equals(fname)){
                            method.invoke(obj,number.byteValue());
                        }else if("short".equals(fname)||"java.lang.Short".equals(fname)){
                            method.invoke(obj,number.shortValue());
                        }else if("long".equals(fname)||"java.lang.Long".equals(fname)){
                            method.invoke(obj,number.longValue());
                        }else if("float".equals(fname) || "java.lang.Float".equals(fname)){
                            method.invoke(obj,number.floatValue());
                        }else if("double".equals(fname)||"java.lang.Double".equals(fname)){
                            method.invoke(obj,number.doubleValue());
                        }
                    }else {
                        method.invoke(obj,objValue);
                    }
                }
                list.add(obj);
            }
//            System.out.println(count);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            JDBCUtil.closeConnection(connection,pstem,resultSet);
        }
        return list;
    }
~~~

## 3.利用反射做出通用 sql插入

需求：输入一个对象 我就能插入对应表中

~~~java
 //获得get方法名
    public String getGetName(String name){
        return "get"+name.substring(0,1).toUpperCase()+name.substring(1);
    }

/*
 *object 插入的表，也就是对象
 */
 @Override
    public void save(Object object) {
        //存储有值的属性
        List<String> list = new ArrayList<>();
        //存储属性值
        List<Object> rList = new ArrayList<>();
        Class<?> aClass = object.getClass();
        Connection connection = null;
        PreparedStatement pstem = null;
        //获得表名
        String name = aClass.getSimpleName().toUpperCase();
        //获得所有属性
        Field[] fields = aClass.getDeclaredFields();
        Method method =null;
        try {
            for(Field field : fields){
                //获得get方法
                method = aClass.getMethod(getGetName(field.getName()));
                //获取被设置值的属性
                Object o = method.invoke(object);
               //拿取属性和属性值
                if(o != null) {
                    list.add(field.getName());
                    rList.add(o);
                }
            }
            //拼接表字段和 ？
            String str ="";
            String resule ="";
            for (String l :list){
                resule += l+",";
                str +="?,";
            }
            //切掉多余的 ,
            str=str.substring(0,str.length()-1);
            resule=resule.substring(0,resule.length()-1);
            //拼接的sql
            String sql ="insert into "+name+"("+resule+") values (" +str +")";
            //获得连接
            connection = JDBCUtil.getConnection();
            pstem = connection.prepareStatement(sql);
            //用拿取到的值设置回去
            for (int i = 0; i <list.size() ; i++) {
                pstem.setObject(i+1,rList.get(i));
            }
            pstem.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            JDBCUtil.closeConnection(connection,pstem);
        }
    }
~~~

