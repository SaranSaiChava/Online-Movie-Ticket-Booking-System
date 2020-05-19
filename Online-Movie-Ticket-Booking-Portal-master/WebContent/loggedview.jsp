<%@ page import="com.mysql.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Vallickavu Cinemas</title>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<nav class="navbar navbar-inverse" style="margin-bottom:0px;">
        <% 
    String username = (String)request.getAttribute("Username");
    		%>
<div class="container">
    <div class="navbar-header">
      <a class="navbar-brand" href="loggedview.jsp" style="font-size: 50px;"><b>Vallickavu Cinemas</b></a>
    </div>
   	
    <ul class="nav navbar-nav navbar-right">
    <li><a data-toggle="modal" data-target="#myModal3"><span class="glyphicon glyphicon-calendar"></span><b></b></a></li>
    <li><a href="#">Hi!! <%=username %></a></li>
    <li><a  data-toggle="modal" data-target="#myModal2">My profile</a></li>
    <li><a href="/new/view.jsp">Logout</a></li>
  </ul>
    </div>
</nav>

<body>
<!-- Date selection module starts -->
<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="myModal3" role="dialog">
      <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Date Selection</h4>
          </div>
          <div class="modal-body">
                <%
         java.util.Date dNow = new java.util.Date();
         SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
      %>
      <% 
    String username2 = (String)request.getAttribute("Username");
      System.out.println("date debug "+ft.format(dNow));
    		%>
            <form action="dateselection" method="POST"><p>Select DATE
        <input type="text" onfocus="(this.type='date')" id="udate" name="udate" placeholder=<%=ft.format(dNow) %> /></p>
        <p><input type="hidden" value=<%=username2 %> name="Username"></p>
        <p><input type="hidden" value="0" name="flag"></p>
        <input type="submit" class="btn btn-primary">
    </form>



          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- Date selection module ends -->
<center>
<!-- carousel of posters for a better uEx -->
<div id="carousel-example-generic" class="carousel slide container-fluid" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="images/Poster4.jpg" alt="..." style="width:800px; height:500px;">
      <div class="carousel-caption">
        <b>Now Showing</b>
      </div>
    </div>
    <div class="item">
      <img src="images/Poster3.jpg" alt="..." style="width:800px;height:500px;">
      <div class="carousel-caption">
       <b>Now Showing</b>
      </div>
    </div>
    <div class="item">
      <img src="images/Poster2.jpg" alt="..." style="width:800px;height:500px;">
      <div class="carousel-caption">
       <b>Now Showing</b>
      </div>
    </div>
    <div class="item">
      <img src="images/Poster1.jpg" alt="..." style="width:800px;height:500px;">
      <div class="carousel-caption">
      <b>Now Showing</b>
      </div>
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>



<br>
<br>
<br>
<% 
    String msg = (String)request.getAttribute("msg");
	if(msg==null){
    		%>
<marquee behavior="scroll" direction="left" scrollamount="3">Login Successful</marquee>
<%}else{ %>
<marquee behavior="scroll" direction="left" scrollamount="3"><%=msg%></marquee>
<%} %>
<form action="book" method="post">
<div>
  <div class="container" style="float:left; margin-left:150px;">



            <%
            Class.forName("com.mysql.jdbc.Driver");  
        	Connection conn=DriverManager.getConnection(  
        	"jdbc:mysql://localhost:3306/newdb","root","password");
                Statement stmt = null;
                Statement stmt2 = null;
                Statement stmt3 = null;
                stmt = conn.createStatement();
                stmt2 = conn.createStatement();
                stmt3 = conn.createStatement();
                String udate =(String)request.getAttribute("udate");
                String query=null;
                if(udate!=null){
        		 query = "select Mid from shows inner join moviedatabase where shows.Mid=moviedatabase.id and moviedatabase.tilldate>'"+udate+"' and moviedatabase.bookingstartdate<='"+udate+"' group by Mid ";
        		}
                else{
                	query = "select Mid from shows inner join moviedatabase where shows.Mid=moviedatabase.id and moviedatabase.tilldate>curdate() and moviedatabase.bookingstartdate<=curdate()  group by Mid;";
                }
                ResultSet rs = null;
                rs = stmt.executeQuery(query);
                while(rs.next()){
            %>
            
                <%
                    
                
                  int Mid = rs.getInt("Mid");
                  String query2 = "select title,genere, duration,photo from moviedatabase where id="+Mid;
                  ResultSet rs2 = null;
                  ResultSet rs3 = null;
                  String query3="select * from shows where Mid="+Mid;
                    rs2 = stmt2.executeQuery(query2);
                    rs3 = stmt3.executeQuery(query3);
                    String moviename=null;
                    int duration=0;
                    int id=0;
                    String genre=null;
                    String base64Image=null;
                    Blob blob=null;
                    boolean a=true;
                    while(a && rs2.next()){
                      moviename = rs2.getString("title");
                      duration= rs2.getInt("duration");
                      genre=rs2.getString("genere");
                      blob = rs2.getBlob("photo");
                      
                      InputStream inputStream = blob.getBinaryStream();
                      ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                      byte[] buffer = new byte[4096];
                      int bytesRead = -1;
                       
                      while ((bytesRead = inputStream.read(buffer)) != -1) {
                          outputStream.write(buffer, 0, bytesRead);                  
                      }
                       
                      byte[] imageBytes = outputStream.toByteArray();
                      base64Image= Base64.getEncoder().encodeToString(imageBytes);
                       
                       
                      inputStream.close();
                      outputStream.close();
                      a=false;
                    }               
                %>
                <div class="row">
  <div class="column">
    <div class="card">
    	<img src="data:image/jpg;base64,<%=base64Image%>" alt="Avatar" style="width:200px;height:300px">
    			<h4><b><%=moviename %></b></h4>
                <p><%=duration %> minutes</p>
                <p><%=genre %></p>
                <select name=<%=Mid %>>
                <%while(rs3.next()){
                	  id = rs3.getInt("id");
                      int screen = rs3.getInt("screen");
                      int slot = rs3.getInt("slot");
                      int avail = rs3.getInt("booked");
                      String start=null;
                      if(slot==1){
                        start="9:00 AM";
                      }
                      else if(slot==2){
                        start="01:00 PM";
                      }
                      else if(slot==3){
                        start="04:30 PM";
                      }
                      else if(slot==4){
                      	start="08:00 PM";
                      }
                      else if(slot==5){
                      	start="11:00 PM";
                      }
                      if(screen==1){
                      	avail=200-avail;
                      }
                      if(screen==2){
                      	avail=150-avail;
                      }
                      if(screen==3){
                      	avail=150-avail;
                      }
                      if(screen==4){
                    	  avail=110-avail;
                      }
                      int array[]={id,Mid};
                      %>
                      <option value=<%=id %>>SCREEN <%=screen%>|| START <%=start%></option>
                      <% 
                } %>
        		</select>
                <p><input type="radio" value=<%=Mid %> name="Mid"> Confirm</p>
                <a data-toggle="modal" data-target="#myModal1"><b>Book</b></a>
  </div>
  </div>                      

            <%      
                }
            %>
  </div>
</div>



<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="myModal1" role="dialog">
      <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Book Movie</h4>
          </div>
          <div class="modal-body">
            
<h1>Book Movie</h1>
			<h4> </h4>
			<h4> </h4>
			
          <input type="number" name="num" placeholder="No. Of Seats">
          <br />
          <select name="class">
              <option value="silver">Silver - Rs.100</option>
              <option value="gold">Gold - Rs.150</option>
              <option value="platinum">Platinum - Rs.200</option>
        </select>
        <% 
    String username1 = (String)request.getAttribute("Username");
        if(udate==null){
        	udate=ft.format(dNow);
        }
        System.out.println("date debug "+udate);
    		%>
        <select name="user">
              <option value=<%=username1 %>>Credit/DebitCards</option>
              <option value=<%=username1 %>>Upi</option>
        </select>
          <br /><br />
          <input type="hidden" id="date" name="date" value=<%=udate %>>
          
          <input class="btn btn-primary"  type="submit" value="BOOK NOW">


          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">back</button>
          </div>
        </div>
      </div>
    </div>
  </div>







</form>
</center>
<% 
    String msg1 = (String)request.getAttribute("msg");
	if(msg1==null){
    		%>
<marquee behavior="scroll" direction="left" scrollamount="3">Login Successful</marquee>
<%}else{ %>
<marquee behavior="scroll" direction="left" scrollamount="3"><%=msg1%></marquee>
<%} %>
</body>

<style>
      /* NOTE: The styles were added inline because Prefixfree needs access to your styles and they must be inlined if they are on local disk! */
body, div, dl, dt, dd, ol, h1, h2, h3, h4, h5, h6, pre, form, fieldset, input, textarea, p, blockquote, th, td { 
  padding:0;
  margin:0;}

body,
input,
textarea,
select {
  font-family: 'Open Sans', sans-serif;
  font-size: 16px;
  color: #4c4c4c;
}

.testbox3 {
	float:right;
  /*margin: 20px auto;*/
  width: 300px; 
  /*height: 330px;*/ 
  -webkit-border-radius: 8px/7px; 
  -moz-border-radius: 8px/7px; 
  border-radius: 8px/7px; 
  background-color: #ebebeb; 
  -webkit-box-shadow: 1px 2px 5px rgba(0,0,0,.31); 
  -moz-box-shadow: 1px 2px 5px rgba(0,0,0,.31); 
  box-shadow: 1px 2px 5px rgba(0,0,0,.31); 
  border: solid 1px #cbc9c9;
}

.testbox3{
  height: 185px; 
}

form{
  margin: 0 30px;
}

input[type=text],input[type=password]{
  width: 200px; 
  height: 39px; 
  -webkit-border-radius: 0px 4px 4px 0px/5px 5px 4px 4px; 
  -moz-border-radius: 0px 4px 4px 0px/0px 0px 4px 4px; 
  border-radius: 0px 4px 4px 0px/5px 5px 4px 4px; 
  background-color: #fff; 
  -webkit-box-shadow: 1px 2px 5px rgba(0,0,0,.09); 
  -moz-box-shadow: 1px 2px 5px rgba(0,0,0,.09); 
  box-shadow: 1px 2px 5px rgba(0,0,0,.09); 
  border: solid 1px #cbc9c9;
  margin-left: -5px;
  margin-top: 13px; 
  padding-left: 10px;
}

input[type=password]{
  margin-bottom: 25px;
}
input[type=text]{
  margin-bottom: 25px;
}
a {
  text-decoration: none;
}

nav {
    font-family: monospace;
    width:100%;
}
.column {
  float: left;
  width: 25%;
  padding: 0 10px;
}

/* Remove extra left and right margins, due to padding in columns */
.row {margin: 0 -5px;}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Style the counter cards */
.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* this adds the "card" effect */
  padding: 16px;
  text-align: center;
  background-color: #f1f1f1;
}

/* Responsive columns - one column layout (vertical) on small screens */
@media screen and (max-width: 800px) {
  .column {
    width: 100%;
    display: block;
    margin-bottom: 20px;
  }
}

</style>
</html>