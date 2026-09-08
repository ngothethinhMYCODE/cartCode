<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="murach.business.Product" %>
<%@ page import="murach.data.ProductIO" %>
<%
    List<Product> products = ProductIO.getProducts();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Murach's Java Servlets and JSP</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; color: #008080; }
        h2 { color: #008080; font-size: 20px; }
        table { border-collapse: collapse; width: 100%; max-width: 750px; color: #000; }
        th, td { border: 1px solid black; padding: 6px 10px; text-align: left; }
        .price-col { width: 90px; text-align: right; padding-right: 15px; }
        .action-col { width: 100px; text-align: center; }
        button { cursor: pointer; }
    </style>
</head>
<body>

    <h2>CD list</h2>

    <table>
        <thead>
            <tr>
                <th>Description</th>
                <th class="price-col">Price</th>
                <th class="action-col"></th>
            </tr>
        </thead>
        <tbody>
            <% for (Product p : products) { %>
                <tr>
                    <td><%= p.getDescription() %></td>
                    <td class="price-col">$<%= String.format("%.2f", p.getPrice()) %></td>
                    <td class="action-col">
                        <form action="cart" method="post" style="margin: 0;">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productCode" value="<%= p.getCode() %>">
                            <button type="submit">Add To Cart</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>