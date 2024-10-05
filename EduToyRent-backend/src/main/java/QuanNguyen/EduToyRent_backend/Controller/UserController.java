package QuanNguyen.EduToyRent_backend.Controller;

import QuanNguyen.EduToyRent_backend.entity.User;
import QuanNguyen.EduToyRent_backend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/Users")
    public List<User> getAll(){
        return userService.getAll();
    }
    @GetMapping("/Users/{id}")
    public User getById(@PathVariable Integer id){
        return userService.getById(id);
    }

    @PostMapping("/User")
    public User save(@RequestBody User user){
        return userService.save(user);
    }

    @DeleteMapping("/User/{id}")
    public void deleteById(@PathVariable Integer id){
        userService.delete(id);
    }
}
