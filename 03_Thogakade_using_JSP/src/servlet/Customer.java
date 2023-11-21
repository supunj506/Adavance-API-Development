/*
 * Author  : supun@mj
 * Project : Adavnce API Development
 * Date    : 11/20/2023
 * Time    : 9:31 PM
 * For GDSE course of IJSE Institute.
 */

package servlet;

import db.DBConnection;
import dto.CustomerDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(urlPatterns = "/customer")
public class Customer extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        ArrayList<CustomerDTO> customerList = new ArrayList<>();
        try {
            Connection connection = DBConnection.getInstance().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("select * from customer");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {

                customerList.add(new CustomerDTO(resultSet.getString(1), resultSet.getString(2), resultSet.getString(3), resultSet.getDouble(4)));

            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        double salary = Double.parseDouble(req.getParameter("salary"));
        String option = req.getParameter("option");


        switch (option) {
            case "save":
                try {
                    Connection connection = DBConnection.getInstance().getConnection();
                    PreparedStatement stm = connection.prepareStatement("insert into customer values (?,?,?,?)");
                    stm.setString(1, id);
                    stm.setString(2, name);
                    stm.setString(3, address);
                    stm.setDouble(4, salary);
                    int i = stm.executeUpdate();
                    if (i > 0) {
                        resp.getWriter().write("<h1>Successfully save Customer </h1>");
                    }

                } catch (SQLException | ClassNotFoundException e) {
                    throw new RuntimeException(e);
                }

                break;
            case "update":
                try {
                    Connection connection = DBConnection.getInstance().getConnection();
                    PreparedStatement stm = connection.prepareStatement("update customer set name=?,address=?,salary=? where id=?");
                    stm.setString(1,name);
                    stm.setString(2,address);
                    stm.setDouble(3,salary);
                    stm.setString(4,id);
                    int i = stm.executeUpdate();
                    if(i>0){
                        resp.getWriter().write("<h1>Successfully Update Customer </h1>");
                    }

                } catch (SQLException | ClassNotFoundException e) {
                    throw new RuntimeException(e);
                }
                break;

            case "delete":
                try {
                    Connection connection = DBConnection.getInstance().getConnection();
                    PreparedStatement stm = connection.prepareStatement("delete from customer where id=?");
                    stm.setString(1,id);
                    int i = stm.executeUpdate();
                    if(i>0){
                        resp.getWriter().write("<h1>Successfully Delete Customer </h1>");
                    }

                } catch (SQLException | ClassNotFoundException e) {
                    throw new RuntimeException(e);
                }
                break;

        }



        /*send save customer data in table using writer------------------------------------------------------------------*/
        /*resp.getWriter().write("<table style='width:50%';>");
        resp.getWriter().write("<thead> <tr> <th>id</th> <th>name</th> <th>address</th> <th>salary</th> </tr> </thead>");
        resp.getWriter().write("<tbody>");
        resp.getWriter().write("<tr> <td>"+id+"</td><td>"+name+"</td><td>"+address+"</td><td>"+salary+"</td> </tr>");
        resp.getWriter().write("</tbody>");
        resp.getWriter().write("</table>");
        resp.sendRedirect("index.html");*/
    }


}
