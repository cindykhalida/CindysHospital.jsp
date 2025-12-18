/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ASUS
 */
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;


public class LogoutServlet extends HttpServlet {
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
request.getSession().invalidate();
response.sendRedirect("login.jsp");
}
}

