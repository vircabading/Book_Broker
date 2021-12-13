package com.vcabading.bookbroker.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.vcabading.bookbroker.models.Book;

////////////////////////////////////////////////////////////////
//	BOOK REPOSITORY
////////////////////////////////////////////////////////////////

@Repository
public interface BookRepository extends CrudRepository<Book, Long> {

	//	---- Retrieves all books -------------------------------
	List<Book> findAll();
}