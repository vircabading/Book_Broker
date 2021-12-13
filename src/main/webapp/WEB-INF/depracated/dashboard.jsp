<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>

<!--/////////////////////////////////////////////////////
//	DASHBOARD JSP
///////////////////////////////////////////////////////// -->

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- //// CSS LINKS //////////////////////////////////////// -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<title>Book Club</title>
</head>
<body>
	<!-- //// HEADER /////////////////////////////////////////// -->
	<header>
		<div class="navbar navbar-dark bg-dark box-shadow">
			<div class="container d-flex justify-content-between">
				<a href="/" class="col-8 navbar-brand"> <strong
					class="text-warning">BOOK CLUB</strong>
				</a>
				<div class="col-4 row align-items-center">
					<p class="col text-white m-2">${ loggedInUser.userName }</p>
					<button class="col btn btn-info btn-sm round m-2"
						onclick="window.location.href='/books';">Home</button>
					<button class="col btn btn-danger btn-sm round"
						onclick="window.location.href='/logout';">Log-Out</button>
				</div>
			</div>
		</div>
	</header>

	<!-- //// MAIN AREA //////////////////////////////////////// -->
	<main role="main">
		<div class="container mt-4">
			<div class="row">
				<h1>Welcome, ${ loggedInUser.userName }</h1>
				<div class="bg-info round p-3">
					<div class="d-flex justify-content-between align-items-center">
						<h2>Books from everyone's shelves:</h2>
						<div class="d-flex justify-content-end align-items-center">
							<button class="col btn btn-warning btn-sm round"
								onclick="window.location.href='/books/new';">Add a Book
								to my Shelf</button>
						</div>
					</div>
					<!-- //// TABLE TO DISPLAY ALL BOOKS //////// -->
					<table class="table">
						<thead>
							<tr>
								<th scope="col"><strong>ID</strong></th>
								<th scope="col"><strong>Title</strong></th>
								<th scope="col"><strong>Author</strong></th>
								<th scope="col"><strong>Posted By</strong></th>
								<th scope="col"><strong>Action</strong></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="eachBook" items="${ bookList }">
								<tr>
									<td>${ eachBook.id }</td>
									<td><a class="text-dark text-decoration-none"
										href="/books/${ eachBook.id }">${ eachBook.title }</a></td>
									<td>${ eachBook.author }</td>
									<td>${ eachBook.user.userName }</td>
									<td class="row">
										<!-- **** Button that points to Book View ************ -->
										<div class="col">
											<button class="btn btn-primary btn-sm round"
												onclick="window.location.href='/books/${ eachBook.id }';">View</button>
										</div> <c:choose>
											<c:when test="${user_id == eachBook.user.id}">
												<div class="col">
													<button class="btn btn-warning btn-sm round"
														onclick="window.location.href='/books/${ eachBook.id }/edit';">Edit</button>
												</div>
												<!-- **** Button that deletes Book ************ -->
												<form class="col" action="/books/${ eachBook.id }/delete"
													method="post">
													<input type="hidden" name="_method" value="delete">
													<!-- ### Converts method of form to DELETE ### -->
													<button class="btn btn-danger btn-sm round">Delete</button>
												</form>
											</c:when>
										</c:choose> 
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>

	<!-- //// JAVASCRIPT LINKS ///////////////////////////////// -->
	<script src="/webjars/jquery/jquery.min.js"></script>
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/app.js"></script>
</body>