
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.text.DateFormat;
import java.text.ParseException;
 
@WebServlet("/userinput")
@MultipartConfig(maxFileSize = 16177215)
public class Input extends HttpServlet {
 
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
         
        // read form fields
        String movieName = request.getParameter("movieName");
        String genere = request.getParameter("genere");
        String duration = request.getParameter("duration");
        String director = request.getParameter("director");
        String date = request.getParameter("tilldate");
        String sdate = request.getParameter("startdate");
        //java.text.DateFormat df = new java.text.SimpleDateFormat("MM/dd/yyyy");
        java.text.DateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
        java.util.Date tilldate=null;
        java.util.Date startdate=null;
        try {
            //java.util.Date d = df.parse(Date);
        	startdate=format.parse(sdate);
            tilldate = format.parse(date);
        } catch (ParseException ex) {
            //Logger.getLogger(ReserveServlet.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex);
        }
        java.sql.Date tdate= new java.sql.Date(tilldate.getTime());
        java.sql.Date stdate = new java.sql.Date(startdate.getTime());
        InputStream inputStream = null; // input stream of the upload file
        
        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("poster");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
        System.out.println("movie: " + movieName);
        System.out.println("genere: " + genere);
 
        // do some processing here...
        try
        {
          // create a mysql database connection
        	Class.forName("com.mysql.jdbc.Driver");  
        	Connection conn=DriverManager.getConnection(  "jdbc:mysql://localhost:3306/newdb","root","password"); 

          // the mysql insert statement
          String query = " insert into moviedatabase (title, genere, duration, director,photo,tilldate,bookingstartdate)"
            + " values (?, ?, ?, ?, ?,?,?);";

          // create the mysql insert preparedvstatement
          PreparedStatement preparedStmt = conn.prepareStatement(query);
          preparedStmt.setString (1, movieName);
          preparedStmt.setString (2, genere);
          preparedStmt.setInt(3, Integer.parseInt(duration));
          preparedStmt.setString(4, director);
          preparedStmt.setDate(6, tdate);
          preparedStmt.setDate(7, stdate);
          if (inputStream != null) {
              // fetches input stream of the upload file for the blob column
              preparedStmt.setBlob(5, inputStream);
          }

          // sends the statement to the database server
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