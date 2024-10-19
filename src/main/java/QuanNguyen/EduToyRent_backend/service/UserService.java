package QuanNguyen.EduToyRent_backend.service;

import QuanNguyen.EduToyRent_backend.entity.*;
import QuanNguyen.EduToyRent_backend.reposisoty.UserRepo;
import io.jsonwebtoken.ExpiredJwtException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private static final Logger log = LoggerFactory.getLogger(UserService.class);
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private AuthenticationManager authManager;
    @Autowired
    private JwtService jwtService;
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    public User getUserById(Integer id) throws Exception{
        return userRepo.findById(id).orElseThrow(() -> new Exception("Không tìm thấy người dùng với UID: " + id));
    }

    public List<User> getAll(){
        return userRepo.findAll();
    }

    public User save(User user){
        return userRepo.save(user);
    }
    public void delete(Integer userID){
        userRepo.deleteById(userID);
    }

    public ResponseEntity<?> login(UserLogin userLogin){
        // Nếu username là email, kiểm tra và lấy username từ email
        if(userLogin.getUsername().contains("@")){
            Optional<User> user1 = userRepo.findByEmail(userLogin.getUsername());
            // Nếu email không tồn tại trong DB, trả về thông báo lỗi
            if (!user1.isPresent()) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Incorrect username or password. Please try again.");
            }
            // Cập nhật username từ đối tượng User tìm thấy qua email
            userLogin.setUsername(user1.get().getUsername());
        }
        try {
            //Xác thực ng dùng
            Authentication authentication = authManager.authenticate(new UsernamePasswordAuthenticationToken(userLogin.getUsername(), userLogin.getPassword()));
            UserPrinciple userPrinciple = (UserPrinciple) authentication.getPrincipal();

            User user = userPrinciple.getUser();

            String token = jwtService.generateToken(user.getUsername(), user.getUid());
            LoginResponse loginResponse = new LoginResponse(token, user.getUsername(), user.getRole(), user.getUid());
            return ResponseEntity.ok(loginResponse);
        } catch (BadCredentialsException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Incorrect username or password. Please try again.");
        } catch (ExpiredJwtException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Your session has expired. Please log in again.");
        }
        catch (AuthenticationException e) {
            // Xử lý các lỗi xác thực khác
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Login failed. Please check your credentials and try again.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An unexpected error occurred. Please try again later.");
        }
    }

    public ResponseEntity<?> register(UserRegister userRegister) {
        // Kiểm tra xem email hoặc username đã tồn tại hay chưa
        if (userRepo.findByEmail(userRegister.getEmail()).isPresent()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Email đã tồn tại!");
        }
        if (userRepo.findByUsername(userRegister.getUsername()).isPresent()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Username đã tồn tại!");
        }
        // Tạo đối tượng User mới từ thông tin đăng ký
        User newUser = new User();
        newUser.setUsername(userRegister.getUsername());
        newUser.setEmail(userRegister.getEmail());
        newUser.setPhone(userRegister.getPhone());
        // Băm mật khẩu trước khi lưu vào database
        String encodedPassword = passwordEncoder.encode(userRegister.getPassword());
        newUser.setPassword(encodedPassword);

        newUser.setRole("ROLE_CUSTOMER");

        userRepo.save(newUser);

        return ResponseEntity.status(HttpStatus.CREATED).body("Đăng ký thành công!");
    }
}
