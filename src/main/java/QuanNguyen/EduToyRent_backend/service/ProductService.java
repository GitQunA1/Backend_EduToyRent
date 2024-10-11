package QuanNguyen.EduToyRent_backend.service;

import QuanNguyen.EduToyRent_backend.entity.Product;
import QuanNguyen.EduToyRent_backend.reposisoty.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductRepo productRepo;

    public Product addProduct(Product product){
        return productRepo.save(product);
    }

    public Product updateProductById(Integer id, Product productDetail) throws Exception{
        Product existingProduct = productRepo.findById(id).orElseThrow(() -> new Exception("Product not found"));
        //cập nhật thuộc tính
        existingProduct.setName(productDetail.getName());
        existingProduct.setImage(productDetail.getImage());
        existingProduct.setPrice(productDetail.getPrice());
        existingProduct.setQsell(productDetail.getQsell());
        existingProduct.setQrent(productDetail.getQrent());
        existingProduct.setAge(productDetail.getAge());
        existingProduct.setBrand(productDetail.getBrand());
        existingProduct.setOrigin(productDetail.getOrigin());
        existingProduct.setDescription(productDetail.getDescription());
        existingProduct.setCategory(productDetail.getCategory());
        existingProduct.setStatus(productDetail.getStatus());

        return productRepo.save(existingProduct);
    }

    public void deleteProductById(Integer productId){
        if(productRepo.existsById(productId)){
            productRepo.deleteById(productId);
        } else {
            throw new RuntimeException("Product not found");
        }
    }

    public Product getProductById(Integer productId){
        return productRepo.findById(productId).orElseThrow(() -> new RuntimeException("Product not found"));
    }

    public List<Product> getAllProducts(){
        return  productRepo.findAll();
    }

    public List<Product> findProductByCategory(String category){
        return  productRepo.findByCategory(category);
    }

    public List<Product> findProductByPriceBetween(BigDecimal minPrice, BigDecimal maxPrice){
        return productRepo.findByPriceBetween(minPrice, maxPrice);
    }

    public List<Product> findProductByAgeBetween(Integer minAge, Integer maxAge){
        return productRepo.findByAgeBetween(minAge, maxAge);
    }

    public List<Product> searchProductsByKeyword(String keyword){
        return productRepo.searchProductsByKeyword(keyword);
    }
}
