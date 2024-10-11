package QuanNguyen.EduToyRent_backend.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Staff")
public class Staff implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SID")
    private Integer sid;

    @OneToOne
    @JoinColumn(name = "UID", referencedColumnName = "UID")
    private User user;

    @Column(name = "Avatar")
    private String avatar;

    @Column(name = "Name")
    private String name;

    @Column(name = "Sex")
    private String sex;

    @Column(name = "Birthday")
    private Date birthday;

    //Phương thức này để biết cá nhân hay tổ chức
    @Column(name = "Office")
    private String office;

    public Staff() {}

    public Staff(String avatar, String name, String sex, Date birthday, String office, User user) {
        this.avatar = avatar;
        this.name = name;
        this.sex = sex;
        this.birthday = birthday;
        this.office = office;
        this.user = user;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
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

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getOffice() {
        return office;
    }

    public void setOffice(String office) {
        this.office = office;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
