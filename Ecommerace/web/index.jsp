<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
%>
<!DOCTYPE html>
<html>
<head>
    <title>E-Commerce Home</title>
</head>
<body>

<h1>Welcome to Our E-Commerce Store</h1>

<nav>
    <a href="index.jsp">Home</a> |
    <a href="ProductServlet">Products</a> |
    <% if (currentUser != null) { %>
        <a href="cart.jsp">Cart</a> |
        <a href="orders.jsp">My Orders</a> |
        <a href="LogoutServlet">Logout</a>
    <% } else { %>
        <a href="login.jsp">Login</a> |
        <a href="register.jsp">Register</a>
    <% } %>
</nav>

<hr>

<% if (currentUser != null) { %>
    <p>Hello, <strong><%= currentUser.getName() %></strong>! Welcome back.</p>
<% } else { %>
    <p>Welcome, guest! Please <a href="login.jsp">login</a> or <a href="register.jsp">register</a> to start shopping.</p>
<% } %>

<h2>Featured Categories</h2>
<ul>
    <li><a href="products.jsp?category=1">Electronics</a></li>
    <li><a href="products.jsp?category=2">Books</a></li>
    <li><a href="products.jsp?category=3">Clothing</a></li>
</ul>

</body>
</html>
