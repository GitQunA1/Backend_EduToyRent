package QuanNguyen.EduToyRent_backend.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Table(name = "Product")
public class Product implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PID")
    private Integer pid;

    @ManyToOne
    @JoinColumn(name = "SOID", referencedColumnName = "SOID")
    private Shop_Owner shopowner;

    @Column(name = "Image")
    private String image;

    @Column(name = "Name")
    private String name;

    @Column(name = "Price")
    private BigDecimal price;

    @Column(name = "QSell")
    private Integer qsell;

    @Column(name = "QRent")
    private String qrent;

    @Column(name = "Age")
    private Integer age;

    @Column(name = "Brand")
    private String brand;

    @Column(name = "Origin")
    private String origin;

    @Column(name = "Description")
    private String description;

    @Column(name = "Category")
    private String category;

    @Column(name = "Status")
    private String status;

    public Product () {}

    public Product(Shop_Owner shopowner, String image, String name, BigDecimal price, Integer qsell, String qrent, Integer age, String brand, String origin, String description, String category, String status) {
        this.shopowner = shopowner;
        this.image = image;
        this.name = name;
        this.price = price;
        this.qsell = qsell;
        this.qrent = qrent;
        this.age = age;
        this.brand = brand;
        this.origin = origin;
        this.description = description;
        this.category = category;
        this.status = status;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Shop_Owner getShopowner() {
        return shopowner;
    }

    public void setShopowner(Shop_Owner shopowner) {
        this.shopowner = shopowner;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getQsell() {
        return qsell;
    }

    public void setQsell(Integer qsell) {
        this.qsell = qsell;
    }

    public String getQrent() {
        return qrent;
    }

    public void setQrent(String qrent) {
        this.qrent = qrent;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
