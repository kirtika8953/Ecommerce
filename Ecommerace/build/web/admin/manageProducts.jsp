<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Product" %>
<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Products list should be set by AdminServlet
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Products</title>
</head>
<body>

<h1>Manage Products</h1>

<nav>
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="manageProducts.jsp">Manage Products</a> |
    <a href="manageUsers.jsp">Manage Users</a> |
    <a href="manageOrders.jsp">Manage Orders</a> |
    <a href="../LogoutServlet">Logout</a>
</nav>

<hr>

<h2>All Products</h2>

<% if (products == null || products.isEmpty()) { %>
    <p>No products found.</p>
<% } else { %>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price (₹)</th>
            <th>Stock</th>
            <th>Category</th>
            <th>Action</th>
        </tr>
        <% for (Product p : products) { %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getName() %></td>
                <td><%= p.getDescription() %></td>
                <td><%= p.getPrice() %></td>
                <td><%= p.getStock() %></td>
                <td><%= p.getCategoryName() %></td>
                <td>
                    <form action="../AdminServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="deleteProduct">
                        <input type="hidden" name="id" value="<%= p.getId() %>">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
        <% } %>
    </table>
<% } %>

<hr>

<h2>Add New Product</h2>
<form action="../AdminServlet" method="post">
    <input type="hidden" name="action" value="addProduct">
    Name: <input type="text" name="name" required><br>
    Description: <input type="text" name="description"><br>
    Price: <input type="number" step="0.01" name="price" required><br>
    Stock: <input type="number" name="stock" required><br>
    Category ID: <input type="number" name="categoryId" required><br>
    Image URL: <input type="text" name="imageUrl"><br>
    <button type="submit">Add Product</button>
</form>

</body>
</html>
