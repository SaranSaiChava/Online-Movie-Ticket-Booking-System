import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.text.ParseException;
import java.util.Base64;
import java.util.concurrent.TimeUnit;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/book")
public class book extends HttpServlet {
	static int cost=0;
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // read form fields	
        String MovId = request.getParameter("Mid");
        String showId = request.getParameter(MovId);
        String username=request.getParameter("user");
        String Bdate = request.getParameter("date");
        java.text.DateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
        java.util.Date bddate=null;
        try {
            //java.util.Date d = df.parse(Date);
        	bddate=format.parse(Bdate);
        } catch (ParseException ex) {
            //Logger.getLogger(ReserveServlet.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex);
        }
        java.sql.Date bdate= new java.sql.Date(bddate.getTime());
        System.out.println(username);
        
        
        request.setAttribute("Username",username);
        request.setAttribute("Bdate", Bdate);
        
        
        int num = Integer. parseInt(request.getParameter("num"));
        String clss = request.getParameter("class");
        System.out.println(clss);
//        System.out.println("movie: " + movieId);
//        System.out.println("genere: " + screen+" "+slot);
 
        // do some processing here...
        try
        {
          // create a mysql database connection
        	Class.forName("com.mysql.jdbc.Driver");  
        	Connection conn=DriverManager.getConnection(  
        	"jdbc:mysql://localhost:3306/newdb","root","password");
          // the mysql insert statement
          Statement stmt = null;
          Statement stmt1 = null;
          stmt = conn.createStatement();
          stmt1 = conn.createStatement();
          String query = " select MId, screen, slot, booked from shows where id="+showId;
          String query1 = " select id from users where name=\""+username+"\"";
          System.out.println("Show ID"+showId);
          ResultSet rs = null,rs1=null ,rs2=null;
          int screen=0, slot=0, booked=0, MId=0;
          rs = stmt.executeQuery(query);
          rs1=stmt1.executeQuery(query1);
          PrintWriter writer = response.getWriter();
          String htmlRespone = "<html>";
          int userId=0;
          while(rs1.next()){
        	  userId=rs1.getInt("id");
          }
          
          if(rs==null){
        	  htmlRespone += "<h2>Wrong Entry</h2><br/>"; 
          }
          while(rs.next()){
        	  screen = rs.getInt("screen");
        	  slot = rs.getInt("slot");
        	  booked = rs.getInt("booked");
        	  MId = rs.getInt("MId");
          }
          
          query = " select * from moviedatabase where id="+MId;
          rs = stmt.executeQuery(query);
          String name=null,genere=null,director=null;
          int duration=0;
          while(rs.next()){
        	  name = rs.getString("title");
        	  genere = rs.getString("genere");
        	  duration = rs.getInt("duration");
        	  director = rs.getString("director");
          }
         String htmlResponse2;
        // return response
          
          if(clss.equals("silver")){
        	  cost=100;
          }
          else if(clss.equals("gold")){
        	  cost=150;
          }
          else if(clss.equals("platinum")){
        	  cost=200;
          }
          //Booking table updation
          String bquerry="insert into booking(Sid,userid,dateOfBooking,Mdate) values(?,?,curdate(),?);";
          PreparedStatement preparedStmtb = conn.prepareStatement(bquerry);
          preparedStmtb.setInt(1,Integer.parseInt(showId));
          preparedStmtb.setInt(2,userId);
          preparedStmtb.setDate(3, bdate);
          cost*=num;
          System.out.println(cost);
          boolean bflag=false;
          switch(screen) {
          case 1: if(booked+num>200) {
        	  			htmlRespone += "<center><h2>Show Full</h2><br/></center>";
          			}
		          else {
		        	  	booked+=num;
		        	  	htmlRespone += "<center><div style='border:1px solid black; border-radius:3px; width:400px;'><h2>Tickets Booked</h2><hr><br/><h3>Please pay Rs." + cost + "</h3><br><hr><p>order: "+ num+" x " +clss+" tickets<br>Movie: "+name+"- ("+duration+" minutes)</p><h2>Screen: 1</h2><br><h2>Slot: "+slot+"</h2></div></center>"; 
  	          			query = " update shows set booked="+booked+" where id="+showId;
  	          			bflag=true;
		          }
          			break;
          case 2: if(booked+num>150) {
			  			htmlRespone += "<center><h2>Show Full</h2><br/></center>";
					}
		        else {
		      	  	booked+=num;
		      	  	htmlRespone += "<center><div style='border:1px solid black; border-radius:3px; width:400px;'><h2>Tickets Booked</h2><hr><br/><h3>Please pay Rs." + cost + "</h3><br><hr><p>order: "+ num+" x " +clss+" tickets<br>Movie: "+name+"- ("+duration+" minutes)</p><h2>Screen: 2</h2><br><h2>Slot: "+slot+"</h2></div></center>"; 
		      			query = " update shows set booked="+booked+" where id="+showId;
		      			bflag=true;		        }
			break;
          case 3: if(booked+num>150) {
			  			htmlRespone += "<center><h2>Show Full</h2><br/></center>";
					}
		        else {
		      	  	booked+=num;
		      	  	htmlRespone += "<center><div style='border:1px solid black; border-radius:3px; width:400px;'><h2>Tickets Booked</h2><hr><br/><h3>Please pay Rs." + cost + "</h3><br><hr><p>order: "+ num+" x " +clss+" tickets<br>Movie: "+name+"- ("+duration+" minutes)</p><h2>Screen: 3</h2><br><h2>Slot: "+slot+"</h2></div></center>"; 
		      			query = " update shows set booked="+booked+" where id="+showId;
		      			bflag=true;		        }
			break;
          case 4: if(booked+num>110) {
		  			htmlRespone += "<center><h2>Show Full</h2><br/></center>";
				}
	        else {
	      	  	booked+=num;
	      	  	htmlRespone += "<center><div style='border:1px solid black; border-radius:3px; width:400px;'><h2>Tickets Booked</h2><hr><br/><h3>Please pay Rs." + cost + "</h3><br><hr><p>order: "+ num+" x " +clss+" tickets<br>Movie: "+name+"- ("+duration+" minutes)</p><h2>Screen: 4</h2><br><h2>Slot: "+slot+"</h2></div></center>"; 
	      			query = " update shows set booked="+booked+" where id="+showId;
	      			bflag=true;	        }
          	break;
			
		  default: htmlRespone += "<center><h2>Wrong Input</h2><br/></center>"; 
          }
          System.out.println(query);
      	  PreparedStatement preparedStmt = conn.prepareStatement(query);
      	  preparedStmt.execute();
      	  preparedStmtb.execute();
      	  conn.close();
      	  
      	  
      	  htmlRespone += "</html>";
      	  writer.println(htmlRespone);
      	  htmlRespone="<br><center><a href='food.jsp' style='font-size:30px;'>Order Meal</a><br><br></center>";
      	  writer.println(htmlRespone);
      	  
      	  request.setAttribute("slot", Integer.toString(slot));
      	  request.setAttribute("screen", Integer.toString(screen));
      	  request.setAttribute("booked", Integer.toString(num));
      	  request.setAttribute("class", clss);
      	  request.setAttribute("cost", Integer.toString(cost));
      	  request.setAttribute("Mname",name);      	  
      	  request.setAttribute("msg","Congratulations "+username+" ! Your booking was succesfull ");
      	  RequestDispatcher req = request.getRequestDispatcher("ticket.jsp");
		  req.forward(request, response);
        }
        catch (Exception e)
        {
          System.err.println("Got an exception!");
          System.err.println(e.getMessage());
        }       
    }
}