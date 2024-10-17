package QuanNguyen.EduToyRent_backend.entity;

public class LoginResponse {
    private String token;
    private String userName;
    private String role;
    private Integer userId;

    public LoginResponse() {
    }

    public LoginResponse(String token, String userName, String role, Integer userId) {
        this.token = token;
        this.userName = userName;
        this.role = role;
        this.userId = userId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

}
