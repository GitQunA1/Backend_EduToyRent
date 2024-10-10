package QuanNguyen.EduToyRent_backend.entity;

import jakarta.persistence.*;

import java.io.Serializable;
@Entity
@Table(name = "Shop_Owner")
public class Shop_Owner implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SOID")
    private Integer soid;

    @OneToOne
    @JoinColumn(name = "UID", referencedColumnName = "UID")
    private User user;

    @Column(name = "Avatar")
    private String avatar;

    @Column(name = "Name")
    private String name;

    @Column(name = "Citizen_code")
    private String citizenCode;

    @Column(name = "Warehouse")
    private String warehouse;

    @Column(name = "Type")
    private String type;

    @Column(name = "Wallet_Shop")
    private Integer wallet;

    public Shop_Owner() {}

    public Shop_Owner(User user, String avatar, String name, String citizenCode, String warehouse, String type, Integer wallet) {
        this.user = user;
        this.avatar = avatar;
        this.name = name;
        this.citizenCode = citizenCode;
        this.warehouse = warehouse;
        this.type = type;
        this.wallet = wallet;
    }

    public Integer getSoid() {
        return soid;
    }

    public void setSoid(Integer soid) {
        this.soid = soid;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCitizenCode() {
        return citizenCode;
    }

    public void setCitizenCode(String citizenCode) {
        this.citizenCode = citizenCode;
    }

    public String getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(String warehouse) {
        this.warehouse = warehouse;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getWallet() {
        return wallet;
    }

    public void setWallet(Integer wallet) {
        this.wallet = wallet;
    }
}
