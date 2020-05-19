
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.ParseException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dateselection")
public class dateSelection extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
         
    	String date = request.getParameter("udate");
    	String username=request.getParameter("Username");
    	int flag=Integer.parseInt(request.getParameter("flag"));
		java.text.DateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.util.Date udate=null;
		System.out.println(flag+"  "+(flag==1));
		try {
            //java.util.Date d = df.parse(Date);
            udate = format.parse(date);
        } catch (ParseException ex) {
            //Logger.getLogger(ReserveServlet.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex);
        }
		
        request.setAttribute("udate",date);
        request.setAttribute("Username",username);
        if(flag==1) {
        	RequestDispatcher req = request.getRequestDispatcher("view.jsp");
    		req.forward(request, response);
        }
        else {
	        RequestDispatcher req = request.getRequestDispatcher("loggedview.jsp");
			req.forward(request, response);
        }
        }
         
        // return response
        

    
}