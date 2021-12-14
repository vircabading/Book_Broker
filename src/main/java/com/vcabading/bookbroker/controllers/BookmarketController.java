package com.vcabading.bookbroker.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.vcabading.bookbroker.models.Book;
import com.vcabading.bookbroker.models.User;
import com.vcabading.bookbroker.services.BookService;
import com.vcabading.bookbroker.services.UserService;

////////////////////////////////////////////////////////////////////
//BOOKMARKET CONTROLLER
////////////////////////////////////////////////////////////////////

@Controller
@RequestMapping("/bookmarket")
public class BookmarketController {

	//	//// FIELDS ////////////////////////////////////////////////

	@Autowired
	private UserService userServ;

	@Autowired
	private BookService bookServ;

	//	//// BOOKS SHOW ////////////////////////////////////////////
	//	Show information from a Book

	//	**** GET: Render book information **************************
	@GetMapping("/{id}")
	public String bookmarketId(@PathVariable("id") Long id, Model model, HttpSession session) {
		//	---- Check if User is Logged In  -----------------------
		if (session.isNew() || session.getAttribute("user_id") == null) {
			return "redirect:/";
		}
		//	---- Get the Log In User -------------------------------
		User loggedInUser = this.userServ.retrieveUser((Long) session.getAttribute("user_id"));
		model.addAttribute("loggedInUser", loggedInUser);
		//	---- Get Book specified by ID --------------------------
		Book book = this.bookServ.retrieveBook(id);
		model.addAttribute("book", book);
		return "bookmarketid.jsp";
	}

	//	//// BOOKMARKET NEW /////////////////////////////////////////////
	//	Add a Book to bookmarket

	//	**** GET: Render Form **************************************
	@GetMapping("/new")
	public String bookmarketNew(Model model, HttpSession session) {
		//    	---- Check if User is Logged In  -------------------
		if (session.isNew() || session.getAttribute("user_id") == null) {
			return "redirect:/";
		}
		//	---- Get the Log In User -------------------------------
		User loggedInUser = this.userServ.retrieveUser((Long) session.getAttribute("user_id"));
		model.addAttribute("loggedInUser", loggedInUser);
		//	---- Get a New Book ------------------------------------
		Book newBook = new Book();
		model.addAttribute("newBook", newBook);
		return "bookmarketnew.jsp";
	}

	//	**** POST: Add New Book to database *************************
	@PostMapping("/new")
	public String booksNewPost(@Valid @ModelAttribute("newBook") Book newBook, BindingResult result, Model model,
			HttpSession session) {
		// 	---- Check if User is Logged In  ------------------------
		if (session.isNew() || session.getAttribute("user_id") == null) {
			return "redirect:/";
		}
		//	---- Get the Log In User --------------------------------
		User loggedInUser = this.userServ.retrieveUser((Long) session.getAttribute("user_id"));
		model.addAttribute("loggedInUser", loggedInUser);
		if (result.hasErrors()) {
			return "bookmarketnew.jsp";
		} else {
			//newBook.setUser(loggedInUser);
			newBook.setOwner(loggedInUser);
			this.bookServ.create(newBook);
			return "redirect:/bookmarket";
		}
	}

	//	//// BOOKS EDIT ////////////////////////////////////////////
	//	Edit information from a Book

    //	**** GET: Render Edit Form *********************************
    @GetMapping("/{id}/edit")
    public String booksmarketEdit(@PathVariable("id") Long id,
    							Model model, HttpSession session) {
    	//  ---- Check if User is Logged In  -----------------------
    	if (session.isNew() || session.getAttribute("user_id") == null) {
    		return "redirect:/";
    	}
    	//	---- Get the Log In User -------------------------------
    	User loggedInUser = this.userServ.retrieveUser((Long) session.getAttribute("user_id"));
    	model.addAttribute("loggedInUser", loggedInUser);
    	//	---- Get Book specified by ID --------------------------
    	Book oldBook = this.bookServ.retrieveBook(id);
    	model.addAttribute("oldBook", oldBook);
    	return "bookmarketidedit.jsp";
    }
    
    //	**** PUT: Update Old Book on database *************************
    @PutMapping("/{id}/edit")
    public String bookmarketEditPutt(@Valid @ModelAttribute("oldBook") Book oldBook,
    		BindingResult result, @PathVariable("id") Long id,
    		Model model, HttpSession session) {
    	// 	---- Check if User is Logged In  ------------------------
    	if (session.isNew() || session.getAttribute("user_id") == null) {
    		return "redirect:/";
    	}
    	//	---- Get the Log In User --------------------------------
    	User loggedInUser = this.userServ.retrieveUser((Long) session.getAttribute("user_id"));
    	model.addAttribute("loggedInUser", loggedInUser);
    	if (result.hasErrors()) {
            return "bookmarketidedit.jsp";
        } else {
        	this.bookServ.update(oldBook);
            return "redirect:/bookmarket/" + oldBook.getId();
        }
    }

	//	//// BOOKS DELETE //////////////////////////////////////////

	@DeleteMapping("/{id}/delete")
	public String booksIdDelete(@PathVariable("id") Long id, Model model, HttpSession session) {
		//	---- Check if User is Logged In  ------------------------
    	if (session.isNew() || session.getAttribute("user_id") == null) {
    		return "redirect:/";
    	}
		this.bookServ.delete(id);
		return "redirect:/bookmarket";
	}

	//	//// BOOKS BORROW //////////////////////////////////////////
	
	@GetMapping("/{id}/borrow")
	public String bookmarketBorrow(@PathVariable("id") Long bookId, HttpSession session) {
		//	---- Check if User is Logged In  ------------------------
    	if (session.isNew() || session.getAttribute("user_id") == null) {
    		return "redirect:/";
    	}
    	//	---- Get the Log In User --------------------------------
    	User loggedInUser = this.userServ.retrieveUser((Long) session.getAttribute("user_id"));
		Book book = this.bookServ.retrieveBook(bookId);
		book.setBorrower(loggedInUser);
		this.bookServ.update(book);
		return "redirect:/bookmarket";
	}
	
	//	//// BOOKS RETURN //////////////////////////////////////////
	
	@GetMapping("/{id}/return")
	public String bookmarketIdReturn(@PathVariable("id") Long bookId, HttpSession session) {
		//	---- Check if User is Logged In  ------------------------
    	if (session.isNew() || session.getAttribute("user_id") == null) {
    		return "redirect:/";
    	}
    	//	---- Get the book specified by book id ------------------
		Book book = this.bookServ.retrieveBook(bookId);
		book.setBorrower(null);
		this.bookServ.update(book);
		return "redirect:/bookmarket";
	}
}