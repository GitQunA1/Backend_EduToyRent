package QuanNguyen.EduToyRent_backend.Controller;

import QuanNguyen.EduToyRent_backend.entity.Product;
import QuanNguyen.EduToyRent_backend.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/api")
public class ProductController {
    @Autowired
    private ProductService productService;

    @PostMapping("/product")
    public Product createProduct(@RequestBody Product product){
        return productService.addProduct(product);
    }

    @PutMapping("/product/{id}")
    public Product updateProduct(@PathVariable Integer id, @RequestBody Product productDetail) throws Exception{
        return productService.updateProductById(id, productDetail);
    }

    @DeleteMapping("/product")
    public void deleteProduct(@PathVariable Integer id){
        productService.deleteProductById(id);
    }

    @GetMapping("/product/{id}")
    public Product getProductById(Integer id){
        return productService.getProductById(id);
    }

    @GetMapping("/product")
    public List<Product> getAllProduct(){
        return productService.getAllProducts();
    }

    @GetMapping("/product/category/{category}")
    public List<Product> getProductByCategory(@RequestBody String category){
        return productService.findProductByCategory(category);
    }

    @GetMapping("/product/price")
    public List<Product> getProductByPrice(BigDecimal minPrice, BigDecimal maxPrice){
        return productService.findProductByPriceBetween(minPrice, maxPrice);
    }

    @GetMapping("/product/age")
    public List<Product> getProductByAge(Integer minAge, Integer maxAge){
        return productService.findProductByAgeBetween(minAge, maxAge);
    }

    @GetMapping("/prouct/keyword")
    public List<Product> getProductByKeyword(String keyword){
        return productService.searchProductsByKeyword(keyword);
    }
}
