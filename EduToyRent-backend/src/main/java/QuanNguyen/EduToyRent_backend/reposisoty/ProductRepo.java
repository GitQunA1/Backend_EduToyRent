package QuanNguyen.EduToyRent_backend.reposisoty;

import QuanNguyen.EduToyRent_backend.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface ProductRepo extends JpaRepository<Product, Integer> {
    //Tìm kiếm theo Category
    List<Product> findByCategory(String category);

    //Tìm theo khoảng giá
    List<Product> findByPriceBetween(BigDecimal minPrice, BigDecimal maxPrice);

    //Tìm sản phẩm theo độ tuổi phù hợp
    List<Product> findByAgeBetween(Integer minAge, Integer maxAge);

    //Tìm sản phẩm theo từ khóa (name, description) kh phân biệt hoa thường
    @Query("SELECT p FROM Product p WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(p.description) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Product> searchProductsByKeyword(@Param("keyword") String keyword);
}
