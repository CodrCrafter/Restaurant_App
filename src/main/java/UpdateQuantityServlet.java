import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.restaurant.model.Cart;

@WebServlet("/updateQuantity")
public class UpdateQuantityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String action = req.getParameter("action");

        Cart cart = (Cart) req.getSession().getAttribute("cart");

        if (cart != null) {
            if (action.equals("inc")) {
                cart.increaseQuantity(id);
            } else if (action.equals("dec")) {
                cart.decreaseQuantity(id);
            }
        }

        res.sendRedirect("cart.jsp");
    }
}
