<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.CustomerDTO" %>
<!--/*
* Author : supun@mj
* Project : Advance API Development
* Date : 11/20/2023
* Time : 1:31 PM
* For GDSE course of IJSE Institute.
*/-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Advance API Development</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;500&display=swap');

        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
            height: 100vh;
            margin: 0;
            background-color: #ffffff;
        }

        #headerDiv {
            width: 80%;
            height: 10vh;
            font-family: 'Roboto', serif;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
        }

        #headerBtnDiv {
            width: 40%;
            height: 100%;
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        #headerBtnDiv > button {
            color: #fff;
            border: 1px solid #eee;
            border-radius: 10px;
            box-shadow: 5px 5px 5px #eee;
            text-shadow: none;
            width: 30%;
            height: 60%;
            font-size: 20px;
            cursor: pointer;
            font-family: 'Roboto', serif;
        }

        /*-------------------------------------*/
        #mainPane {
            width: 90%;
            /*background-color: #B9DFFF;*/
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        #customerBtn {
            background-color: #2ecc71;
        !important;
        }

        #itemBtn {
            background-color: aqua;
        }

        #orderBtn {
            background-color: #8e44ad;
        }

        /*--------------------------------------*/


        #customerPane {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
        }

        #cusSubPane {
            width: 100%;
            display: flex;
            justify-content: space-between;
        }


        #cusForm {
            width: 50%;
            height: 50vh;
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            align-items: center;

        }

        .cusInputDiv {
            width: 60%;
            height: 12%;

        }

        input {
            width: 100%;
            height: 100%;
            border-radius: 10px;
            border: 0 none;
            user-focus-pointer: none;
            font-size: 15px;
            background-color: #f5f6fa;
            padding-left: 5%;

        }

        input:focus {
            outline: none !important;
            border-color: #B9DFFF;
            box-shadow: 0 0 10px #B9DFFF;
        }

        #cusBtnDiv {
            display: flex;
            justify-content: space-around;
            align-items: center;
            /*background: black;*/
            width: 80%;
        }

        .cusBtn {
            background: #B9DFFF;
            color: /*#fff*/ white;
            border: 1px solid #eee;
            border-radius: 10px;
            box-shadow: 5px 5px 5px #eee;
            text-shadow: none;
            width: 20%;
            height: 90%;
            font-size: 20px;
            cursor: pointer;
        }

        #cusSave {
            background: #00ff0c;
        }

        #cusUpdate {
            background: aqua;
        }

        #cusDelete {
            background: #e74c3c;
        }

        #clear {
            background: #ff0006;
        }

        #customerTable {
            width: 50%;
            /*line-height:20px;*/
            border-collapse: collapse;
            height: 100%;

        }

        #customerTable > thead > tr > th {
            text-align: left;
            padding: 10px;
            background: #B9DFFF;
        }

        #customerTable > thead > tr {
            border-bottom: 2px solid black;
            height: 40px;
        }


        #customerTable > tbody > tr {
            border-bottom: 2px solid green;
            height: 40px;
        }


    </style>
</head>
<body>
<%
    ArrayList<CustomerDTO> allCustomer = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/thogakadeaad", "root", "1234");
        PreparedStatement stm = connection.prepareStatement("SELECT * FROM customer");
        ResultSet resultSet = stm.executeQuery();
        while (resultSet.next()){
            allCustomer.add(new CustomerDTO(resultSet.getString("id"),resultSet.getString("name"),resultSet.getString("address"),resultSet.getDouble("salary")));

        }

    } catch (ClassNotFoundException | SQLException e) {
        throw new RuntimeException(e);
        }

%>

<div id="headerDiv">
    <h1>Thogakade Using JSP</h1>

    <div id="headerBtnDiv">
        <button id="customerBtn">Customer</button>
        <button id="itemBtn">Item</button>
        <button id="orderBtn">Order</button>
    </div>

</div>

<section id="mainPane">

    <div id="customerPane">
        <h1>Customer Data Manipulate Form</h1>
        <hr style="width: 90%;height: 1px;background-color: black">
        <div id="cusSubPane">
            <form id="cusForm" method="post">
                <div class="cusInputDiv">
                    <input id="cusId" type="text" placeholder="Id" name="id">
                </div>
                <div class="cusInputDiv">

                    <input id="cusName" type="text" placeholder="Name" name="name">
                </div>
                <div class="cusInputDiv">

                    <input id="cusAddress" type="text" placeholder="Address" name="address">
                </div>
                <div class="cusInputDiv">

                    <input id="cusSalary" type="text" placeholder="Salary" name="salary">
                </div>

                <div class="cusInputDiv" id="cusBtnDiv">

                    <button id="cusSave" class="cusBtn" type="submit" form="cusForm" formaction="customer?option=save">
                        Save
                    </button>
                    <button id="cusUpdate" class="cusBtn" type="submit" form="cusForm"
                            formaction="customer?option=update">Update
                    </button>
                    <button id="cusDelete" class="cusBtn" type="submit" form="cusForm"
                            formaction="customer?option=delete">Delete
                    </button>
                    <button id="clear" class="cusBtn" type="button">Clear</button>
                </div>

            </form>

            <table id="customerTable">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>Salary</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for(CustomerDTO customerDTO:allCustomer){

                %>
              <tr>
                  <td><%=customerDTO.getId()%></td>
                  <td><%=customerDTO.getName()%></td>
                  <td><%=customerDTO.getAddress()%></td>
                  <td><%=customerDTO.getSalary()%></td>
              </tr>

                <%
                    }
                %>


                </tbody>
            </table>

        </div>
    </div>

</section>
<script src="asset/JQuery/jquery-3.6.4.min.js"></script>
<script>
    let cusId = $("#cusId");
    let cusName = $("#cusName");
    let cusAddress = $("#cusAddress");
    let cusSalary = $("#cusSalary");

    $("#customerTable > tbody > tr ").click(function (){
        console.log("row Click");
    });


    $("#clear").click(function () {
        let answer = confirm("If you Want to Clear data ???");
        if (answer) {
            cusId.val("");
            cusName.val("");
            cusAddress.val("");
            cusSalary.val("");
        }
    });
</script>
</body>
</html>