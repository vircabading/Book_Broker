package com.vcabading.bookbroker.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.vcabading.bookbroker.models.LoginUser;
import com.vcabading.bookbroker.models.User;
import com.vcabading.bookbroker.repositories.UserRepository;
   
////////////////////////////////////////////////////////////////
//	USER SERVICE
////////////////////////////////////////////////////////////////

@Service
public class UserService {
    
	//	//// FIELDS ////////////////////////////////////////////
	
    @Autowired
    private UserRepository userRepo;
    
    //	//// CREATE ////////////////////////////////////////////
    
    //	**** Register a New User *******************************
    public User register(User newUser, BindingResult result) {
        if(userRepo.findByEmail(newUser.getEmail()).isPresent()) {		// Check if E-mail is already in database
            result.rejectValue("email", "Unique", "This email is already in use!");
        }
        if(userRepo.findByUserName(newUser.getUserName()).isPresent()) {
            result.rejectValue("userName", "Unique", "This Name is already in use!");
        }
        if(!newUser.getPassword().equals(newUser.getConfirm())) {		// Check to make sure password matches confirm password
            result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
        }
        if(result.hasErrors()) {										// Check if there are errors on the form
            return null;
        } else {														// BCrypt hash the password then create a new User
            String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
            newUser.setPassword(hashed);
            return userRepo.save(newUser);
        }
    }

    //	//// RETRIEVE //////////////////////////////////////////
    
    //	**** Log In the User ***********************************
    public User login(LoginUser newLogin, BindingResult result) {
        if(result.hasErrors()) {										// Check form for errors
            return null;
        }
        
        // Find the User in the database by their email
        Optional<User> potentialUser = userRepo.findByEmail(newLogin.getEmail());
        if(!potentialUser.isPresent()) {								// If User not found, do NOT log in User
            result.rejectValue("email", "Unique", "Unknown email!");
            return null;
        }
        User user = potentialUser.get();								
        // Check the password given in the form vs the password hash in the database
        if(!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
            result.rejectValue("password", "Matches", "Invalid Password!");
        }
        if(result.hasErrors()) {
            return null;
        } else {
            return user;	
        }
    }
    
    //	**** Retrieve User By ID ********************************
    
	public User retrieveUser(Long id) {
		Optional<User> optUser = this.userRepo.findById(id);
		if ( optUser.isPresent() ) {
			return optUser.get();			
		} else {
			return null;
		}
	}
    
}