<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.User, model.Product, model.Order" %>
<%
    // ✅ check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // ✅ statistics (these should be set by AdminServlet)
    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    Integer totalProducts = (Integer) request.getAttribute("totalProducts");
    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");

    if (totalUsers == null) totalUsers = 0;
    if (totalProducts == null) totalProducts = 0;
    if (totalOrders == null) totalOrders = 0;
    if (totalRevenue == null) totalRevenue = 0.0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>

<h1>Admin Dashboard</h1>

<nav>
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="manageProducts.jsp">Manage Products</a> |
    <a href="manageUsers.jsp">Manage Users</a> |
    <a href="manageOrders.jsp">Manage Orders</a> |
    <a href="../LogoutServlet">Logout</a>
</nav>

<hr>

<h2>Statistics</h2>
<ul>
    <li>Total Users: <%= totalUsers %></li>
    <li>Total Products: <%= totalProducts %></li>
    <li>Total Orders: <%= totalOrders %></li>
    <li>Total Revenue: ₹<%= String.format("%.2f", totalRevenue) %></li>
</ul>

</body>
</html>
