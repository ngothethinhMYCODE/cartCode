package murach.cart;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import murach.business.LineItem;
import murach.business.Product;
import murach.data.ProductIO;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "cart";
        }

        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<LineItem> cart = (List<LineItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        if (action.equals("add")) {
            String productCode = request.getParameter("productCode");
            Product product = ProductIO.getProduct(productCode);
            
            boolean exists = false;
            for (LineItem item : cart) {
                if (item.getProduct().getCode().equals(productCode)) {
                    item.setQuantity(item.getQuantity() + 1);
                    exists = true;
                    break;
                }
            }
            if (!exists && product != null) {
                cart.add(new LineItem(product, 1));
            }
        } else if (action.equals("update")) {
            String productCode = request.getParameter("productCode");
            String quantityString = request.getParameter("quantity");
            int quantity = 1;
            try {
                quantity = Integer.parseInt(quantityString);
            } catch (NumberFormatException e) {
                quantity = 1;
            }

            for (int i = 0; i < cart.size(); i++) {
                LineItem item = cart.get(i);
                if (item.getProduct().getCode().equals(productCode)) {
                    if (quantity > 0) {
                        item.setQuantity(quantity);
                    } else {
                        cart.remove(i);
                    }
                    break;
                }
            }
        } else if (action.equals("remove")) {
            String productCode = request.getParameter("productCode");
            cart.removeIf(item -> item.getProduct().getCode().equals(productCode));
        }

        session.setAttribute("cart", cart);

        
        response.sendRedirect("cart");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}