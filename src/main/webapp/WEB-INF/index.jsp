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
//	INDEX JSP
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
				<a href="/" class="navbar-brand d-flex align-items-center"> <strong
					class="text-warning">BOOK CLUB</strong>
				</a>
				<button class="btn btn-info btn-sm round" onclick="window.location.href='/';">Index</button>
			</div>
		</div>
	</header>

	<!-- //// MAIN AREA //////////////////////////////////////// -->
	<main role="main">
		<div class="container mt-4">
			<h1 class="text-primary">
				<strong>Book Club</strong>
			</h1>
			<p>A place for friends to share thoughts on books</p>
			<div class="row">
				<!-- //// REGISTRATION FORM //////////////////////// -->
				<form:form class="col bg-info m-2 p-2 round" action="/"
					method="post" modelAttribute="newUser">
					<input type="hidden" name="_method" value="put">	<!-- ### Converts method of form to PUT ### -->
					<h2><strong>Register:</strong></h2>
					<div class="form-group">
						<label>User Name:</label> <strong> <form:errors
								path="userName" class="text-danger alert mb-3" />
						</strong>
						<form:input path="userName" class="form-control mb-3" />
					</div>
					<div class="form-group">
						<label>Email:</label> <strong> <form:errors path="email"
								class="text-danger text-danger alertmb-3" />
						</strong>
						<form:input path="email" class="form-control mb-3" />
					</div>
					<div class="form-group">
						<label>Password:</label> <strong> <form:errors
								path="password" class="text-danger text-danger alertmb-3" />
						</strong>
						<form:password path="password" class="form-control mb-3" />
					</div>
					<div class="form-group">
						<label>Confirm Password:</label> <strong> <form:errors
								path="confirm" class="text-danger text-danger alert mb-3" />
						</strong>
						<form:password path="confirm" class="form-control mb-3" />
					</div>
					<input type="submit" value="Register" class="btn btn-primary btn-sm round mb-3" />
				</form:form>
				<!-- //// LOGIN FORM //////////////////////// -->
				<form:form class="col bg-info m-2 round p-2" action="/"
					method="post" modelAttribute="newLogin">
					<h2><strong>Log-In</strong></h2>
					<div class="form-group">
						<label>Email:</label> <strong> <form:errors path="email"
								class="text-danger alert mb-3" />
						</strong>
						<form:input path="email" class="form-control mb-3" />
					</div>
					<div class="form-group">
						<label>Password:</label> <strong> <form:errors
								path="password" class="text-danger alert mb-3" />
						</strong>
						<form:password path="password" class="form-control mb-3" />
					</div>
					<input type="submit" value="Login" class="btn btn-success btn-sm round mb-3" />
				</form:form>
			</div>
		</div>
	</main>

	<!-- //// JAVASCRIPT LINKS ///////////////////////////////// -->
	<script src="/webjars/jquery/jquery.min.js"></script>
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/app.js"></script>
</body>