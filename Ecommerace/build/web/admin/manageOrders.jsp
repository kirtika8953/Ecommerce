<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Order, model.OrderItem" %>
<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Orders list should be set by AdminServlet
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders</title>
</head>
<body>

<h1>Manage Orders</h1>

<nav>
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="manageProducts.jsp">Manage Products</a> |
    <a href="manageUsers.jsp">Manage Users</a> |
    <a href="manageOrders.jsp">Manage Orders</a> |
    <a href="../LogoutServlet">Logout</a>
</nav>

<hr>

<% if (orders == null || orders.isEmpty()) { %>
    <p>No orders found.</p>
<% } else { %>
    <% for (Order order : orders) { %>
        <h3>Order #<%= order.getId() %> | User ID: <%= order.getUserId() %> | Date: <%= order.getCreatedAt() %></h3>
        <p>Status: <%= order.getStatus() %></p>

        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>Product</th>
                <th>Price (₹)</th>
                <th>Quantity</th>
                <th>Subtotal (₹)</th>
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

        <!-- Update order status -->
        <form action="../AdminServlet" method="post">
            <input type="hidden" name="action" value="updateOrderStatus">
            <input type="hidden" name="orderId" value="<%= order.getId() %>">
            <select name="status">
                <option value="PLACED" <%= order.getStatus().equals("PLACED") ? "selected" : "" %>>PLACED</option>
                <option value="SHIPPED" <%= order.getStatus().equals("SHIPPED") ? "selected" : "" %>>SHIPPED</option>
                <option value="DELIVERED" <%= order.getStatus().equals("DELIVERED") ? "selected" : "" %>>DELIVERED</option>
                <option value="CANCELLED" <%= order.getStatus().equals("CANCELLED") ? "selected" : "" %>>CANCELLED</option>
            </select>
            <button type="submit">Update</button>
        </form>
        <hr>
    <% } %>
<% } %>

</body>
</html>
