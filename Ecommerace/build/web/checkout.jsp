<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.CartItem" %>
<%
    // Check if user is logged in
    model.User currentUser = (model.User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Cart items (set by CheckoutServlet or CartServlet)
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
</head>
<body>

<h1>Checkout</h1>
<nav>
    <a href="index.jsp">Home</a> |
    <a href="products.jsp">Products</a> |
    <a href="cart.jsp">Cart</a> |
    <a href="orders.jsp">My Orders</a> |
    <a href="LogoutServlet">Logout</a>
</nav>
<hr>

<% if (cartItems == null || cartItems.isEmpty()) { %>
    <p>Your cart is empty. <a href="products.jsp">Shop now</a></p>
<% } else { 
    double total = 0;
%>
    <h2>Order Summary</h2>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Product</th>
            <th>Price (₹)</th>
            <th>Quantity</th>
            <th>Subtotal</th>
        </tr>
        <% for (CartItem item : cartItems) { 
            double subtotal = item.getProduct().getPrice() * item.getQuantity();
            total += subtotal;
        %>
            <tr>
                <td><%= item.getProduct().getName() %></td>
                <td><%= item.getProduct().getPrice() %></td>
                <td><%= item.getQuantity() %></td>
                <td><%= subtotal %></td>
            </tr>
        <% } %>
    </table>
    <h3>Total: ₹<%= total %></h3>

    <h2>Delivery Details</h2>
    <form action="CheckoutServlet" method="post">
        <input type="hidden" name="action" value="placeOrder">
        <label>Full Name:</label><br>
        <input type="text" name="fullname" required><br><br>
        
        <label>Address:</label><br>
        <textarea name="address" rows="3" cols="40" required></textarea><br><br>
        
        <label>Phone:</label><br>
        <input type="text" name="phone" value="<%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %>" required><br><br>
        
        <label>Payment Method:</label><br>
        <select name="paymentMethod" required>
            <option value="COD">Cash on Delivery</option>
            <option value="UPI">UPI</option>
            <option value="CARD">Card</option>
        </select><br><br>
        
        <button type="submit">Place Order</button>
    </form>
<% } %>

</body>
</html>
