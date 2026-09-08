<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="murach.business.LineItem" %>
<%
    @SuppressWarnings("unchecked")
    List<LineItem> cart = (List<LineItem>) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Murach's Java Servlets and JSP</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; color: #008080; }
        h2 { color: #008080; font-size: 20px; }
        table { border-collapse: collapse; width: 100%; max-width: 800px; color: #000; margin-bottom: 15px; }
        th, td { border: 1px solid black; padding: 6px 8px; text-align: left; }
        .qty-col { width: 130px; }
        .price-col { width: 70px; }
        .action-col { width: 110px; text-align: center; }
        input[type="text"] { width: 25px; text-align: center; }
        .note { color: #000; font-weight: bold; margin-bottom: 15px; font-size: 14px; }
        .btn-group button { margin-right: 5px; cursor: pointer; }
    </style>
</head>
<body>

    <h2>Your cart</h2>

    <table>
        <thead>
            <tr>
                <th class="qty-col">Quantity</th>
                <th>Description</th>
                <th class="price-col">Price</th>
                <th class="price-col">Amount</th>
                <th class="action-col"></th>
            </tr>
        </thead>
        <tbody>
            <% if (cart == null || cart.isEmpty()) { %>
                <tr>
                    <td colspan="5" style="text-align: center;">Your cart is empty.</td>
                </tr>
            <% } else { 
                for (LineItem item : cart) { %>
                    <tr>
                        <td class="qty-col">
                            <form action="cart" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="productCode" value="<%= item.getProduct().getCode() %>">
                                <input type="text" name="quantity" value="<%= item.getQuantity() %>">
                                <button type="submit">Update</button>
                            </form>
                        </td>
                        <td><%= item.getProduct().getDescription() %></td>
                        <td class="price-col">$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
                        <td class="price-col">$<%= String.format("%.2f", item.getTotal()) %></td>
                        <td class="action-col">
                            <form action="cart" method="post" style="margin: 0;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="productCode" value="<%= item.getProduct().getCode() %>">
                                <button type="submit">Remove Item</button>
                            </form>
                        </td>
                    </tr>
            <%  } 
               } %>
        </tbody>
    </table>

    <div class="note">
        To change the quantity, enter the new quantity and click on the Update button.
    </div>

    <div class="btn-group">
        <button onclick="window.location.href='index.jsp'">Continue Shopping</button>
        <button onclick="alert('Proceeding to checkout...')">Checkout</button>
    </div>

</body>
</html>