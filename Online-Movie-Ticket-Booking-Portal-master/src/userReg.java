
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userreg")
public class userReg extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
         
        // read form fields
    	String name = request.getParameter("Name");
    	String email =request.getParameter("Email");
        String Username = request.getParameter("Username");
        String phno = request.getParameter("Phone Number");
        String Password = request.getParameter("Password");
        String ReTypePass = request.getParameter("Re-Type Password");
        try {
        Class.forName("com.mysql.jdbc.Driver");  
    	Connection conn=DriverManager.getConnection( "jdbc:mysql://localhost:3306/newdb","root","password");
    	Statement stmt = null;
        stmt = conn.createStatement();
        PrintWriter writer = response.getWriter();
        String query = " insert into users (user,name,email,phno,password)" + " values (?, ?, ?, ?, ?);";
        PreparedStatement preparedStmt = conn.prepareStatement(query);
        preparedStmt.setString (1, name);
        preparedStmt.setString (2, Username);
        preparedStmt.setString(3, email);
        preparedStmt.setString(4, phno);
        preparedStmt.setString(5, Password);
        int flag=0;
        if(Password.equals(ReTypePass)) {
        	 preparedStmt.execute();
        	 flag=1;
        }
        conn.close();
        if(flag==1) {
        	String htmlResponse = "<html>";
            htmlResponse += "<h2>Registration Complete</h2>";        
            htmlResponse += "</html>";
            writer.println(htmlResponse);
            TimeUnit.SECONDS.sleep(3);
        	response.sendRedirect("loggedview.jsp");
        }
        else{
            String htmlResponse = "<html>";
            htmlResponse += "<h2>Invalid Credentials</h2>";        
            htmlResponse += "</html>";
            writer.println(htmlResponse);
            response.sendRedirect("view.jsp");
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