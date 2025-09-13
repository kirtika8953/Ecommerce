<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Product" %>
<%
    // Get logged-in user
    model.User currentUser = (model.User) session.getAttribute("currentUser");

    // Product list should be set by a ProductServlet or similar
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
</head>
<body>

<h1>All Products</h1>

<nav>
    <a href="index.jsp">Home</a> |
    <a href="products.jsp">Products</a> |
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

<% if (products == null || products.isEmpty()) { %>
    <p>No products available at the moment.</p>
<% } else { %>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Product</th>
            <th>Description</th>
            <th>Price (₹)</th>
            <th>Stock</th>
            <th>Action</th>
        </tr>
        <% for (Product p : products) { %>
            <tr>
                <td><%= p.getName() %></td>
                <td><%= p.getDescription() %></td>
                <td><%= p.getPrice() %></td>
                <td><%= p.getStock() %></td>
                <td>
                    <% if (currentUser != null) { %>
                        <form action="CartServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="<%= p.getId() %>">
                            <input type="number" name="quantity" value="1" min="1" max="<%= p.getStock() %>">
                            <button type="submit">Add to Cart</button>
                        </form>
                    <% } else { %>
                        <p><a href="login.jsp">Login to buy</a></p>
                    <% } %>
                </td>
            </tr>
        <% } %>
    </table>
<% } %>

</body>
</html>
