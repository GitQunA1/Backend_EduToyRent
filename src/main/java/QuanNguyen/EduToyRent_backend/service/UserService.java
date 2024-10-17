package QuanNguyen.EduToyRent_backend.service;

import QuanNguyen.EduToyRent_backend.entity.LoginResponse;
import QuanNguyen.EduToyRent_backend.entity.User;
import QuanNguyen.EduToyRent_backend.entity.UserLogin;
import QuanNguyen.EduToyRent_backend.entity.UserPrinciple;
import QuanNguyen.EduToyRent_backend.reposisoty.UserRepo;
import io.jsonwebtoken.ExpiredJwtException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private AuthenticationManager authManager;
    @Autowired
    private JwtService jwtService;

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
        if(userLogin.getUsername().contains("@")){
            Optional<User> user1 = userRepo.findByEmail(userLogin.getUsername());
            userLogin.setUsername(user1.get().getUsername());
        }
        try {
            Authentication authentication = authManager.authenticate(new UsernamePasswordAuthenticationToken(userLogin.getUsername(), userLogin.getPassword()));
            UserPrinciple userPrinciple = (UserPrinciple) authentication.getPrincipal();
            User user = userPrinciple.getUser();

            String token = jwtService.generateToken(user.getUsername());
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
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Login failed. Please check your credentials and try again.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An unexpected error occurred. Please try again later.");
        }
    }

}
