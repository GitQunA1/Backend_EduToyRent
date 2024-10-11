package QuanNguyen.EduToyRent_backend.service;

import QuanNguyen.EduToyRent_backend.entity.User;
import QuanNguyen.EduToyRent_backend.reposisoty.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepo userRepo;

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
}
