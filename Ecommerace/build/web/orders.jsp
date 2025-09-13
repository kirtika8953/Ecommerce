<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Order, model.OrderItem" %>
<%
    // Check if user is logged in
    model.User currentUser = (model.User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Orders should be set by OrderServlet
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
</head>
<body>

<h1>My Orders</h1>

<nav>
    <a href="index.jsp">Home</a> |
    <a href="products.jsp">Products</a> |
    <a href="cart.jsp">Cart</a> |
    <a href="LogoutServlet">Logout</a>
</nav>

<hr>

<% if (orders == null || orders.isEmpty()) { %>
    <p>You have no orders yet. <a href="products.jsp">Shop now</a></p>
<% } else { %>
    <% for (Order order : orders) { %>
        <h3>Order #<%= order.getId() %> | Date: <%= order.getCreatedAt() %></h3>
        <p>Status: <%= order.getStatus() %></p>

        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>Product</th>
                <th>Price (₹)</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
            <% double total = 0;
               for (OrderItem item : order.getItems()) {
                   double subtotal = item.getQuantity() * item.getPriceAtPurchase();
                   total += subtotal;
            %>
                <tr>
                    <td><%= item.getProductName() %></td>
                    <td><%= item.getPriceAtPurchase() %></td>
                    <td><%= item.getQuantity() %></td>
                    <td><%= subtotal %></td>
                </tr>
            <% } %>
        </table>
        <p><strong>Total: ₹<%= total %></strong></p>
        <hr>
    <% } %>
<% } %>

</body>
</html>
