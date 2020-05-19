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

@WebServlet("/backfromtickets")
public class tickets extends HttpServlet {
	static int cost=0;
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        String username=request.getParameter("user");
        String Bdate = request.getParameter("date");		
		request.setAttribute("Username",username);
        request.setAttribute("Bdate", Bdate);
        request.setAttribute("msg","Congratulations "+username+" ! Your booking was succesfull ");
    	RequestDispatcher req = request.getRequestDispatcher("ticket.jsp");
		req.forward(request, response);
		
	}
	}