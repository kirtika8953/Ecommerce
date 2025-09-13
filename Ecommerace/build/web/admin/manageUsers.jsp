<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.User" %>
<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // User list should be set by AdminServlet
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
</head>
<body>

<h1>Manage Users</h1>

<nav>
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="manageProducts.jsp">Manage Products</a> |
    <a href="manageUsers.jsp">Manage Users</a> |
    <a href="manageOrders.jsp">Manage Orders</a> |
    <a href="../LogoutServlet">Logout</a>
</nav>

<hr>

<% if (users == null || users.isEmpty()) { %>
    <p>No users found.</p>
<% } else { %>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Created At</th>
            <th>Action</th>
        </tr>
        <% for (User u : users) { %>
            <tr>
                <td><%= u.getId() %></td>
                <td><%= u.getName() %></td>
                <td><%= u.getEmail() %></td>
                <td><%= u.getPhone() %></td>
                <td><%= u.getCreatedAt() %></td>
                <td>
                    <form action="../AdminServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="deleteUser">
                        <input type="hidden" name="id" value="<%= u.getId() %>">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
        <% } %>
    </table>
<% } %>

</body>
</html>
