package QuanNguyen.EduToyRent_backend.service;

import QuanNguyen.EduToyRent_backend.reposisoty.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerService {
    @Autowired
    private CustomerRepo customerRepo;

}
