
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userlogin")
public class userlogin extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
         
        // read form fields
        String Username = request.getParameter("Username");
        String Password = request.getParameter("Password");
        request.setAttribute("Username",Username);
//        String duration = request.getParameter("duration");
//        String director = request.getParameter("director");
        try {
        	
        //JDBC connection
        Class.forName("com.mysql.jdbc.Driver");  
    	Connection conn=DriverManager.getConnection( "jdbc:mysql://localhost:3306/newdb","root","password");
    	Statement stmt = null;
        stmt = conn.createStatement();
        String query = " select id,name,password from users";
        System.out.println("User Username: " + Username);
        System.out.println("User Password: " + Password);
        PrintWriter writer = response.getWriter();
        ResultSet rs=stmt.executeQuery(query);
        int flag=0;
        while(rs.next()) {
            if(Username.equals(rs.getString("name")) && Password.equals(rs.getString("password"))){
            	request.setAttribute("Uid", rs.getInt("id"));
            	flag=1;
            }

        }
        if(flag==1) {
        	RequestDispatcher req = request.getRequestDispatcher("loggedview.jsp");
			req.forward(request, response);
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