import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
@WebServlet("/delete")
public class delete extends HttpServlet {
 
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
         
        // read form fields
        String movieName = request.getParameter("movieName");
         
        System.out.println("movie: " + movieName);
 
        // do some processing here...
        try
        {
          // create a mysql database connection
        	Class.forName("com.mysql.jdbc.Driver");  
        	Connection conn=DriverManager.getConnection(  
        	"jdbc:mysql://localhost:3306/newdb","root","password");
          // the mysql insert statement
          String query = " delete from moviedatabase where title = ?";

          // create the mysql insert preparedvstatement
          PreparedStatement preparedStmt = conn.prepareStatement(query);
          preparedStmt.setString (1, movieName);
          // execute the preparedstatement
          preparedStmt.execute();
          
          conn.close();
          response.sendRedirect("options.jsp");
        }
        catch (Exception e)
        {
          System.err.println("Got an exception!");
          System.err.println(e.getMessage());
        }
            
         
    }
 
}