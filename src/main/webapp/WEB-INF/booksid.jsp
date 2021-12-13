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
//	BOOKS ID JSP
/////////////////////////////////////////////////////////
	Shows the information on a single Book	 -->

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
			<h1>${ book.title }</h1>
			<div class="bg-info round p-3">
				<h3>
					<strong class="text-danger">${ book.user.userName }</strong> read 
					<strong class="text-primary">${ book.title }</strong> by 
					<strong class="text-success">${ book.author }</strong>
				</h3>
				<p>Here are ${ book.user.userName }'s thoughts:</p>
				<div class="card p-3 round">
					<p>${ book.myThoughts }</p>
				</div>
				<c:choose>
						<c:when test="${user_id == book.user.id}">
							<div class="row mt-3">
								<div class="col-2">
									<button class="btn btn-warning btn-sm round"
										onclick="window.location.href='/books/${ book.id }/edit';">Edit</button>
								</div>
								<!-- **** Button that deletes Book ************ -->
								<form class="col-2" action="/books/${ book.id }/delete"
									method="post">
									<!-- ### Converts method of form to DELETE ### -->
									<input type="hidden" name="_method" value="delete">
									<button class="btn btn-danger btn-sm round">Delete</button>
								</form>
							</div>
						</c:when>
					</c:choose>
			</div>
		</div>
	</main>

	<!-- //// JAVASCRIPT LINKS ///////////////////////////////// -->
	<script src="/webjars/jquery/jquery.min.js"></script>
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/app.js"></script>
</body>