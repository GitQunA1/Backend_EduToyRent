package QuanNguyen.EduToyRent_backend.reposisoty;

import QuanNguyen.EduToyRent_backend.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepo extends JpaRepository<User, Integer> {
    @Query("SELECT u FROM User u WHERE u.id = ?1")
    User getUserById( Integer id);
}

