<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.CartItem" %>
<%
    // Check if user is logged in
    model.User currentUser = (model.User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Cart items (should be set by a CartServlet)
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
</head>
<body>

<h1>Your Shopping Cart</h1>
<nav>
    <a href="index.jsp">Home</a> |
    <a href="products.jsp">Products</a> |
    <a href="orders.jsp">My Orders</a> |
    <a href="LogoutServlet">Logout</a>
</nav>
<hr>

<% if (cartItems == null || cartItems.isEmpty()) { %>
    <p>Your cart is empty.</p>
<% } else { 
    double total = 0;
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Product</th>
            <th>Price (₹)</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th>Action</th>
        </tr>
        <% for (CartItem item : cartItems) { 
            double subtotal = item.getProduct().getPrice() * item.getQuantity();
            total += subtotal;
        %>
            <tr>
                <td><%= item.getProduct().getName() %></td>
                <td><%= item.getProduct().getPrice() %></td>
                <td>
                    <form action="CartServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="updateQuantity">
                        <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1">
                        <button type="submit">Update</button>
                    </form>
                </td>
                <td><%= subtotal %></td>
                <td>
                    <form action="CartServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                        <button type="submit">Remove</button>
                    </form>
                </td>
            </tr>
        <% } %>
    </table>
    <h3>Total: ₹<%= total %></h3>
    <form action="CheckoutServlet" method="post">
        <button type="submit">Proceed to Checkout</button>
    </form>
<% } %>

</body>
</html>
