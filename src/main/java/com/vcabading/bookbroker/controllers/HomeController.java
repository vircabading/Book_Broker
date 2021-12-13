package com.vcabading.bookbroker.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.vcabading.bookbroker.models.Book;
import com.vcabading.bookbroker.models.LoginUser;
import com.vcabading.bookbroker.models.User;
import com.vcabading.bookbroker.services.BookService;
import com.vcabading.bookbroker.services.UserService;

////////////////////////////////////////////////////////////////////
//	HOME CONTROLLER
////////////////////////////////////////////////////////////////////

@Controller
public class HomeController {
	
	//	//// FIELDS ////////////////////////////////////////////////
    
    @Autowired
    private UserService userServ;
    
    @Autowired
    private BookService bookServ;
    
    //	//// SHOW //////////////////////////////////////////////////
   
    //	**** Display the root with Registration and Log-in Forms ***
    @GetMapping("/")
    public String index(Model model, HttpSession session) {
    	//	==== If User is in session --> re-route to dashboard
    	if (session.getAttribute("user_id") != null) {
    		return "redirect:/bookmarket";
    	}
    	
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "index.jsp";
    }
    
    //	**** Display DASHBOARD *************************************
    @GetMapping("/bookmarket")
    public String dashboard(Model model, HttpSession session) {
    	//	---- Check if User is Logged In  -----------------------
    	if (session.isNew() || session.getAttribute("user_id") == null) {
    		return "redirect:/";
    	}
    	//	---- Get the Log In User -------------------------------
    	User loggedInUser = this.userServ.retrieveUser((Long) session.getAttribute("user_id"));
    	model.addAttribute("loggedInUser", loggedInUser);
    	//	---- Get All Books -------------------------------------
    	List<Book> bookList = this.bookServ.retrieveAll();
    	model.addAttribute("bookList", bookList);
    	return "bookmarket.jsp";
    }
    
    //	//// CREATE ////////////////////////////////////////////////
    
    //	**** PUT: Register the New User ****************************

    @PutMapping("/")
    public String register(@Valid @ModelAttribute("newUser") User newUser, 
            BindingResult result, Model model, HttpSession session) {
        userServ.register(newUser, result);
        if(result.hasErrors()) {
            model.addAttribute("newLogin", new LoginUser());
            return "index.jsp";
        }
        session.setAttribute("user_id", newUser.getId());
        return "redirect:/bookmarket";
    }
    
    //	**** POST: Login the User ***********************************

    @PostMapping("/")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
            BindingResult result, Model model, HttpSession session) {
        User user = userServ.login(newLogin, result);
        if(result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "index.jsp";
        }
        session.setAttribute("user_id", user.getId());
        return "redirect:/bookmarket";
    }
    
    //	//// DELETE //////////////////////////////////////////////////
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
    	session.invalidate();					// 	Log the user out
    	return "redirect:/";					//		then redirect to index 
    }
}