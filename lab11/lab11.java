import java.sql.*;

public class lab11 {
    public static void main(String[] args) throws Exception{
        Class.forName("org.postgresql.Driver"); 
        String user = "u7rajchel";
        String pass = "7rajchel";
        Connection con = DriverManager.getConnection("jdbc:postgresql://pascal:5432/u7rajchel",user,pass);
        try {
            DatabaseMetaData
            dm = con.getMetaData();
            String s1 = dm.getURL();
            String s2 = dm.getSQLKeywords();
            boolean b1 = dm.supportsTransactions();
            boolean b2 = dm.supportsSelectForUpdate();
            // debug
            System.out.println(dm);
            System.out.println(s1);
            System.out.println(s2);
            System.out.println(b1);
            System.out.println(b2);
        }
        catch (SQLException e) {}
        con.close();
    }
}