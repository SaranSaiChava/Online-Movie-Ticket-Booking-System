
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class admin extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
         
        // read form fields
        String Username = request.getParameter("Username");
        String Password = request.getParameter("Password");
        
        try {
        Class.forName("com.mysql.jdbc.Driver");  
    	Connection conn=DriverManager.getConnection( "jdbc:mysql://localhost:3306/newdb","root","password");
    	Statement stmt = null;
        stmt = conn.createStatement();
        String query = " select username,pass from adminlogin";
        System.out.println("Username admin: " + Username);
        System.out.println("Password admin: " + Password);
        PrintWriter writer = response.getWriter();
        ResultSet rs=stmt.executeQuery(query);
        int flag=0;
        while(rs.next()){
            if(Username.equals(rs.getString("username")) && Password.equals(rs.getString("pass"))){
            	flag=1;
            }
        }
        if(flag==1) {
        	response.sendRedirect("options.jsp");
        }
        else{
            String htmlResponse = "<html>";
            htmlResponse += "<h2>Invalid Credentials</h2>";        
            htmlResponse += "</html>";
            writer.println(htmlResponse);
        }
        }
        catch (Exception e)
        {
          System.err.println("Got an exception!");
          System.err.println(e.getMessage());
        }
         
        // return response
        
         
    }
}