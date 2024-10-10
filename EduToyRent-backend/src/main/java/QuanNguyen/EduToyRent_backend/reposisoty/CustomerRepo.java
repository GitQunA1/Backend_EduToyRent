package QuanNguyen.EduToyRent_backend.reposisoty;

import QuanNguyen.EduToyRent_backend.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRepo extends JpaRepository<Customer, Integer> {
}
