package com.vcabading.bookbroker.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vcabading.bookbroker.models.Book;
import com.vcabading.bookbroker.repositories.BookRepository;

/////////////////////////////////////////////////////
//	BOOK SERVICE
/////////////////////////////////////////////////////

@Service
public class BookService {

//	//// FIELDS /////////////////////////////////

	@Autowired
	BookRepository bookRepo;

//	//// CREATE /////////////////////////////////

//	---- Create a Dojo --------------------------
	public Book create(Book book) {
		return this.bookRepo.save(book);
	}

//	//// RETRIEVE ///////////////////////////////

//	---- Retrieve All ---------------------------
	public List<Book> retrieveAll() {
		return this.bookRepo.findAll();
	}

//	---- Retrieve Book by ID --------------------
	public Book retrieveBook(Long id) {
		Optional<Book> optBook = this.bookRepo.findById(id);
		if (optBook.isPresent()) {
			Book book = optBook.get();
			return book;
		} else {
			return null;
		}
	}

//	//// UPDATE /////////////////////////////////

	public Book update(Book book) {
		Optional<Book> optBook = this.bookRepo.findById(book.getId());
		if (optBook.isPresent()) {
			return this.bookRepo.save(book);
		} else {
			return null;
		}
	}

//	//// DELETE /////////////////////////////////

	public void delete(Long id) {
		this.bookRepo.deleteById(id);
	}
}