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
    <li><a href="#">Hi!! <%=username %></a></li>
    <li><a href="#">My profile</a></li>
    <li><a href="/new/view.jsp">Logout</a></li>
  </ul>
    </div>
</nav>

<body>
<center>


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
<form action="backfromtickets" method="post">
<div>
  <div class="container" style="float:left; margin-left:150px;">



            <%
            
            //Poster of booked movie retrieved from database using jdbc
            Class.forName("com.mysql.jdbc.Driver");  
        	Connection conn=DriverManager.getConnection(  
        	"jdbc:mysql://localhost:3306/newdb","root","password");
                Statement stmt = null;
                stmt = conn.createStatement();
                String query=null;
                int Mid  = Integer.parseInt(request.getParameter("Mid"));
                query="select photo from moviedatabase where id="+Mid;
                ResultSet rs = null;
                rs = stmt.executeQuery(query);
                Blob blob = null;
                String base64Image=null;
                while(rs.next()){
            %>
            
                <%
                    
                
                blob = rs.getBlob("photo");
                
                InputStream inputStream = blob.getBinaryStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;
                 
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);                  
                }
                 
                byte[] imageBytes = outputStream.toByteArray();
                base64Image = Base64.getEncoder().encodeToString(imageBytes);
                 
                 
                inputStream.close();
                outputStream.close();              
                %>

    	<img src="data:image/jpg;base64,<%=base64Image%>" alt="Avatar" style="width:200px;height:300px">
    	
                    

            <%      
                }
            %>
</div>
</div>

<div style='border:1px solid black; border-radius:3px; width:400px;'>
<h2>Tickets Booked</h2>
<%
String Mname=(String)  request.getAttribute("Mname");

String slot = (String)request.getAttribute("slot");
String screen =(String)request.getAttribute("screen");
String num=  (String)request.getAttribute("booked");
String clas=(String)request.getAttribute("class");
String cost= (String) request.getAttribute("cost");
String date=(String)request.getAttribute("Bdate");
%>
<h3>Please pay Rs.<%=cost %></h3>
<p>order: <%=num %> x <%=clas %> tickets</p>
<p>Movie: <%=Mname %></p>
<h4>Screen: <%=screen %></h4>
<br>
<h4>Slot: <%=slot %></h4>
<a href='food.jsp' style='font-size:30px;'>Order Meal</a><br><br>
<input type="hidden" value=<%=date %> name="date">
<input type="hidden" value=<%=username %> name="name">

<input class="btn btn-primary"  type="submit" value="Back to Booking">
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

