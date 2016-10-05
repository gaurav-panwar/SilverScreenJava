<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>">
<script src="<c:url value="https://apis.google.com/js/api:client.js" />"></script>
<script
	src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"/>"></script>
<script
	src="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"/>"></script>
<!--fontawesome  -->
<script src="<c:url value="https://use.fontawesome.com/4cac0da64a.js"/>"></script>
<link href="<c:url value="/resources/css/bookinghistory.css"/>"
	rel="stylesheet">
<link href="<c:url value="/resources/css/modal.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/jquery.cookie.js" />"></script>
<script src="<c:url value="/resources/js/bookinghistory.js"/>"></script>
<script src="<c:url value="/resources/js/login.js" />"></script>
<link href="<c:url value="/resources/css/login.css" />">



<title>History</title>
</head>

<body>

	<div class="modal fade" id="myModal" role="dialog"
		data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog modal-start">

			<!-- Modal content-->
			<div class="modal-content">

				<div class="modal-body">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">CITY</h4>
					</div>
					<div>
						<br>
						<form name="locForm" action='#'>
							<select id="locate" class="form-control">
								<option value='NCR'>NCR</option>
								<option value='Bengaluru'>Bengaluru</option>

							</select>
						</form>

					</div>
					<div class="modal-footer">
						<button type="button" id="enter-button" data-dismiss="modal">Enter
						
					</div>

				</div>

			</div>
		</div>
	</div>
	<div class="modal fade" id="contactUsModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-phone">&nbsp;</i>CONTACT US
					</h4>
				</div>
				<div class="modal-body">
					<p class=modalcontent>
						<img src='<c:url value="/resources/images/phone-icon.png"/>'>
						+91 9871755697
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						id=closeButton>Close</button>
				</div>
			</div>

		</div>
	</div>

	<div class="modal fade" id="resendModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-phone">&nbsp;</i>RESEND CONFIRMATION
					</h4>
				</div>
				<div class="modal-body" id="formBody">
					<div id=detailsForm>
						<form>
							<div class="form-group">
								<input type="text" class="form-control" id="email"
									placeholder="EMAIL ADDRESS">
							</div>
							<div class="form-group">
								<input type="text" class="form-control" id="num"
									placeholder="MOBILE NUMBER">
							</div>
							<button type="button" class="btn btn-default" id=formSubmit>GET
								DETAILS</button>
						</form>
					</div>

					<div id=resultData style="display: none;">
						<p id=b_id></p>
						<p id=cinema_name></p>
						<p id=audi_num></p>
						<p id=seats_booked></p>
						<p id=dateOfShow></p>
						<p id=timeOfShow></p>
						<p id=pricePerShow></p>
						<button type="submit" class="btn btn-default" id="resetBtn"
							style="background-color: #cc0000; color: #000000; width: 100%">RESET</button>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						id=closeButton>Close</button>
				</div>
			</div>

		</div>
	</div>

	<nav class="navbar navbar-inverse  navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>

			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
					<li><a href="/SilverScreenMavenProject/homepage">Home</a></li>
					<li><a href="/SilverScreenMavenProject/moviesPage">Movies</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">

					<li><a id="location" data-toggle="modal" href="#myModal"
						data-target="#myModal"></a></li>
				</ul>
			</div>
		</div>
		</nav>

		<!-- end of top nav bar -->


		<!-- logo+search bar of the site -->
		<header class="row" style="margin-top: 3%;"> <img style=""
			alt="Silver Screen" id="logoimg"
			src="<c:url value='/resources/images/silverscreen-logo-white.png'/>"
			class="pull-left">

		<form class="col-sm-9 col-sm-offset-2" role="search" name="searchForm"
			style="width: 60%" action="/SilverScreenMavenProject/searchBox">
			<div class="input-group" style="display: block;">
				<a href="/SilverScreenMavenProject/searchBox"><input type="text" class="form-control"
					placeholder="Find Movies or Cinemas you like." name="searchBox"
					id="searchBox" autocomplete="off"></div></a>
				<div class="input-group-btn">
					<button class="btn btn-default" id="searchButton" type="submit">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
			</div>
		</form>
		</header>
	<!-- logo sec finish -->
	<!--user block  -->
	<div class="container-fluid"
		style="margin: 0%; padding: 0%; background-color: #F0F0F0;">
		<img src="<c:url value="/resources/images/back.jpg"/>" alt="user"
			width=80% style="background-color: #F0F0F0;">

	</div>
	<div class="container-fluid" style="margin-top: -10%;">
		<img src="<c:url value="/resources/images/user.png"/>" alt="user"
			width=10%>

	</div>


	<!--second part  -->
	<table class="table table-bordered" style="margin-top: 5%;">
		<thead>
			<tr>
				<th>Name</th>
				<th>Language</th>
				<th>Seats_booked</th>
				<th>Genre</th>
			</tr>
		</thead>
		<tbody id="results"></tbody>
	</table>


	<!--footer  -->
	<div class=container-fluid>
		<footer>
			<div class="lasttab">
				<div class="row">
					<div class="col-sm-offset-1 col-sm-3 col-md-offset-1 col-md-3"
						data-toggle="modal" data-target="#contactUsModal"
						data-backdrop="static" data-keyboard="false">
						<a href="#" class="forlink" id=contact><span
							class="glyphicon glyphicon-user"></span>Contact Us</a>
					</div>
					<div class="col-sm-offset-1 col-md-offset-1 col-sm-1 col-md-1">
					
					</div>


					<div class="col-sm-offset-3 col-md-offset-3 col-sm-3 col-md-3"
						data-toggle="modal" data-target="#resendModal"
						data-backdrop="static" data-keyboard="false">
						<a href="#" class="forlink"><span
							class="glyphicon glyphicon-phone"></span>Resend Confirmation</a>
					</div>
				</div>
			</div>

			</footer>
		</footer>
	</div>
</body>
</html>