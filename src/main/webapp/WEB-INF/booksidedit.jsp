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
//	BOOKS ID EDIT JSP
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
				<div class="col-10">
					<h1>Change your entry, ${ loggedInUser.userName }!</h1>
					<!-- //// FORM TO ENTER A NEW BOOK ///////// -->
					<form:form class="bg-info round p-3"
						action="/books/${ oldBook.id }/edit" method="post"
						modelAttribute="oldBook">
						<!-- ### Convert method of form to PUT ### -->
						<input type="hidden" name="_method" value="put" />
						<!-- **** Title **** -->
						<p class="form-group">
							<form:label path="title">Book Title:</form:label>
							<strong> <form:errors path="title"
									class="alert text-danger" />
							</strong>
							<form:input class="form-control mb-3" path="title" />
						</p>
						<!-- **** Author **** -->
						<p class="form-group">
							<form:label path="author">Book Author:</form:label>
							<strong> <form:errors path="author"
									class="alert text-danger" />
							</strong>
							<form:input class="form-control mb-3" path="author" />
						</p>
						<!-- **** myThoughts **** -->
						<p class="form-group">
							<form:label path="myThoughts">My Thoughts:</form:label>
							<strong> <form:errors path="myThoughts"
									class="alert text-danger" />
							</strong>
							<form:textarea class="form-control mb-3" path="myThoughts" />
						</p>
						<input class="btn btn-warning mb-3" type="submit"
							value="Submit Edit" />
					</form:form>
				</div>
			</div>
		</div>
	</main>

	<!-- //// JAVASCRIPT LINKS ///////////////////////////////// -->
	<script src="/webjars/jquery/jquery.min.js"></script>
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/app.js"></script>
</body>