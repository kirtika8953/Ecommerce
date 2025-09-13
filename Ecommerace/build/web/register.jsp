<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
</head>
<body>

<h1>Create an Account</h1>

<nav>
    <a href="index.jsp">Home</a> |
    <a href="products.jsp">Products</a> |
    <a href="login.jsp">Login</a>
</nav>
<hr>

<!-- Show error or success messages -->
<%
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<%
    } else if (success != null) {
%>
    <p style="color:green;"><%= success %></p>
<%
    }
%>

<form action="RegisterServlet" method="post">
    <label>Name:</label><br>
    <input type="text" name="name" required><br><br>

    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <label>Phone:</label><br>
    <input type="text" name="phone"><br><br>

    <button type="submit">Register</button>
</form>

</body>
</html>
