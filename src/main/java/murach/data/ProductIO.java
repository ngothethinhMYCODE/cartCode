package murach.data;

import java.util.ArrayList;
import java.util.List;
import murach.business.Product;

public class ProductIO {
    public static List<Product> getProducts() {
        List<Product> products = new ArrayList<>();
        products.add(new Product("86band", "86 (the band) - True Life Songs and Pictures", 14.95));
        products.add(new Product("pf01", "Paddlefoot - The first CD", 12.95));
        products.add(new Product("pf02", "Paddlefoot - The second CD", 14.95));
        products.add(new Product("jrut", "Joe Rut - Genuine Wood Grained Finish", 14.95));
        return products;
    }

    public static Product getProduct(String code) {
        for (Product p : getProducts()) {
            if (p.getCode().equalsIgnoreCase(code)) {
                return p;
            }
        }
        return null;
    }
}