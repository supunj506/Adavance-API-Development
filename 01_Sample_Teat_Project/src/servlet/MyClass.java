/*
 * Author  : supun@mj
 * Project : Adavnce API Development
 * Date    : 11/20/2023
 * Time    : 1:28 PM
 * For GDSE course of IJSE Institute.
 */

package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/myservlet")
public class MyClass extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("nic");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        System.out.println(id);
        System.out.println(name);
        System.out.println(address);
        System.out.println(email);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("nic");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        System.out.println(id);
        System.out.println(name);
        System.out.println(address);
        System.out.println(email);
    }
}
