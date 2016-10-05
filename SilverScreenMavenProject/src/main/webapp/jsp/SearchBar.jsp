<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="<c:url value='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'/>"></link>
<script
	src="<c:url value= 'https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js' />"></script>
<script src="<c:url value="https://apis.google.com/js/api:client.js" />"></script>
<script
	src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"/>"></script>
<link rel="stylesheet"
	href="<c:url value='/resources/css/SearchBar.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/modal.css'/>">
<script type="text/javascript"
	src="<c:url value='/resources/js/SearchBar.js'/>"></script>
<script src="<c:url value="/resources/js/jquery.cookie.js" />"></script>


<link rel="icon"
	href="<c:url value='/resources/images/silverscreen-logo-white.png'/>">
	<script src="<c:url value="/resources/js/login.js" />">
	
</script>
<link href="<c:url value="/resources/css/login.css" />">

<title>Search </title>

</head>


<body>
	<!--div for modal  -->
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

	<!--nav bar with links  -->

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
					<li><a href="homepage"><span
							class="glyphicon glyphicon-home"></span></a></li>
					<li><a href="moviesPage">Movies</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li id="log"></li>

					<li><a id="location" data-toggle="modal" href="#myModal"
						data-target="#myModal"></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- end of top nav bar -->


	<!-- logo of the site -->

	<header class="row" style="margin-top: 3%;">
		<img style="" alt="Silver Screen" id="logoimg"
			src="<c:url value='/resources/images/silverscreen-logo-white.png'/>"
			class="pull-left">

		<form class="col-sm-9 col-sm-offset-2" role="search" name="searchForm"
			style="width: 60%">
			<div class="input-group" style="display: block;">
				<input type="text" class="form-control"
					placeholder="Find Movies or Cinemas you like." name="searchBox"
					id="searchBox" autocomplete="off">
				<div class="input-group-btn">
					<button class="btn btn-default" id="searchButton" type="submit">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
			</div>
		</form>
	</header>
	<!-- logo sec finish -->

	<div class="clearfix" />
	<br>
	<br>
	<div class=container-fluid>
		<main id='main-Search' class='col-sm-5 col-sm-offset-3'>
		<ul id='ul-SearchResults' style="list-style: none;">
		</ul>
		</main>

		<div class="clearfix"></div>
		<br>
		<div class="col-sm-4 col-sm-offset-5">
			<button type='button'
				class="btn-default pull-left btn-main-filter active"
				id='btn-MovieSearch'>
				<b>MOVIES</b>
			</button>
			<button type='button' class="btn-default pull-left btn-main-filter"
				id='btn-CinemaSearch'>
				<b>CINEMAS</b>
			</button>
		</div>

		<div class="clearfix"></div>
		<main id="main-Movies"> <br>
		<br>
		<div class="pull-right">
			<button type="button" class="btn-default btn-sub-filter"
				id="btn-lang-Hindi">Hindi</button>
			<button type="button" class="btn-default btn-sub-filter"
				id="btn-lang-English">English</button>
			<button type="button" class="btn-default btn-sub-filter"
				id="btn-lang-Punjabi">Punjabi</button>
			<button type='button' class="btn-default btn-sub-filter"
				id='btn-lang-Tamil'>Tamil</button>
			<button type="button" class="btn-default btn-sub-filter"
				id="btn-lang-Telugu">Telugu</button>
			<button type="button" class="btn-default btn-sub-filter"
				id="btn-lang-Bengali">Bengali</button>
			<button type="button" class="btn-default btn-sub-filter"
				id="btn-lang-Haryanvi">Haryanvi</button>
		</div>
		<br>
		<br>

		<table id='tabHindi' class="col-sm-3 tab-lang">
			<tr>
				<th>HINDI</th>
			</tr>
		</table>

		<table id='tabEnglish' class='col-sm-3 tab-lang'>
			<tr>
				<th>ENGLISH</th>
			</tr>
		</table>

		<div class="col-sm-3">
			<table id='tabPunjabi' class="tab-lang">
				<tr>
					<th>PUNJABI</th>
				</tr>
			</table>

			<table id='tabTamil' class="tab-lang">
				<tr>
					<th>TAMIL</th>
				</tr>
			</table>

			<table id='tabTelugu' class="tab-lang">
				<tr>
					<th>TELUGU</th>
				</tr>
			</table>

		</div>

		<table id='tabBengali' class="tab-lang">
			<tr>
				<th>BENGALI</th>
			</tr>
		</table>

		<table id='tabHaryanvi' class="tab-lang">
			<tr>
				<th>HARYANVI</th>
			</tr>
		</table>

		</main>

		<main id="main-Cinemas">
		<div class="clearfix" />
		<br>
		<br>

		<table id='tabCinemas1' class="col-sm-3">
			<tr>
				<th>CINEMAS</th>
			</tr>
		</table>

		<table id='tabCinemas2' class="col-sm-3">
			<tr>
				<th></th>
			</tr>
		</table>


		<table id='tabCinemas3' class="col-sm-3">
			<tr>
				<th></th>
			</tr>
		</table>

		</main>
	</div>
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
	
	<div class="col-md-offset-3 col-md-6 modal fade" id="login-modal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header modal_Head">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<h4 class="ModalHead_Text">SIGN IN</h4>

					</div>

					<!-- Begin # DIV Form -->
					<div id="div-forms">

						<!-- Begin # Login Form -->

						<div class="modal-body">
							<div class="row">
								<div class="col-md-offset-1 col-md-5">
									<div class="col-md-12" id="gSignInWrapper "
										style="padding-left: 0px; padding-right: 0px;">
										<div id="customBtn"
											class="customGPlusSignIn btn btn-block col-md-12">
											<span class="fa fa-google"> <span class="buttonText">Google</span></span>
										</div>
									</div>
								</div>
								<div class="col-md-5">
									<button
										class="btn btn-primary btn-block btn-social-icon btn-facebook"
										name="fButton" value="fButton" onclick="fbLogin();">
										<span class="fa fa-facebook"></span> Facebook
									</button>
								</div>

								<div
									class="col-xs-offset-5 col-xs-2 col-sm-offset-5 col-sm-2 col-md-offset-5 col-md-2">
									<h2 class="ff">OR</h2>
								</div>
								<form id="login_form" name="login_form" method="get">
									<div class="form-group col-md-offset-2 col-md-8">

										<input type="email" class="form-control " name="Uemail"
											id="Uemail" placeholder="Enter your email id"
											onblur="validateEmail();">
										<div>
											<p id="UemailWarning"></p>
										</div>
									</div>
									<div class="form-group col-md-offset-2 col-md-8">

										<input type="password" class="form-control " name="Upassword"
											id="Upassword" placeholder="Enter your password"
											onblur="validatePwd();">
										<div>
											<p id="UpwdWarning"></p>
										</div>
									</div>
									<div class="col-md-offset-2 col-md-8">
										<button class="btn btn-warning btn-md btn-block"
											name="lnButton" id="lnButton" onclick="loginUser();">Login</button>
									</div>
								</form>
								<br />
								<div class="col-md-offset-4 col-md-4 bt">
									<a href="#forgetPwd-modal" data-toggle="modal"
										data-dismiss="modal"><h6 style="text-align: center;">Forget
											Password</h6></a>
								</div>
								<center>
									<div class="col-md-offset-3 col-xs-12 col-sm-8 col-md-6 signup">
										Still Not Connected? <a id="su" href="#signup-modal"
											data-toggle="modal" data-dismiss="modal"><u>Sign Up</u> </a>
									</div>
								</center>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--Begin sign in form -->
		<div class="col-md-offset-3 col-md-6 modal fade" id="signup-modal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin-left: 0px;">
				<div class="modal-content">
					<div class="modal-header modal_Head">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<h4 class="ModalHead_Text">SIGN UP</h4>
					</div>
					<div id="div-forms2">

						<div class="modal-body">
							<div class="row">
								<form id="signup-form" name="signup_form" method="Get">
									<div class="form-group col-md-offset-2 col-md-8">

										<input type="email" class="form-control " name="Semail"
											id="Semail" placeholder="Enter your email id"
											autocomplete="off" onblur="userNameValidation()" />
										<div>
											<p id="emailWarning"></p>
										</div>
									</div>
									<div class="form-group col-md-offset-2 col-md-8">

										<input type="password" class="form-control " name="Spwd"
											id="Spwd" placeholder="Enter your password"
											autocomplete="off" onblur="pwdValidation()" />
										<div>
											<p id="pwdWarning"></p>
										</div>
									</div>
									<div class="form-group col-md-offset-2 col-md-8">

										<input type="password" class="form-control "
											name="Sconfirm_pwd" id="Sconfirm_pwd"
											placeholder="Confirm password" autocomplete="off"
											onblur="cpwdValidation()" />
										<div>
											<p id="cpwdWarning"></p>
										</div>
										<!-- disabled="disabled" -->
									</div>
									<div class="col-md-offset-2 col-md-8 bt">
										<button id="sinupButton"
											class="btn btn-warning btn-md btn-block" name="siButton"
											id="siButton" onclick="checkAllFeilds();">Sign Up</button>
									</div>
									<!--  -->
								</form>
								<center>
									<div class="col-xs-12 col-sm-8 col-md-offset-3 col-md-6 signup">
										Already Connected? <a id="si" name="si" href="#login-modal"
											data-dismiss="modal" data-toggle="modal"><u>Sign In</u> </a>
									</div>
								</center>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-md-offset-3 col-md-6 modal fade" id="forgetPwd-modal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header modal_Head">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<h4 class="ModalHead_Text">FORGET PASSWORD</h4>

					</div>
					<div id="div-forms3">
						<form id="signup-form">
							<div class="modal-body">
								<div class="row">
									<h4 style="text-align: center;" class="fontFam">Please
										enter your email address below.</h4>

									<div class="form-group col-md-offset-2 col-md-8">

										<input type="email" class="form-control " id="email"
											placeholder="Enter your email id">
									</div>
									<div class="col-md-offset-2 col-md-8 bt">
										<button type="submit" class="btn btn-warning btn-md btn-block">Send
											Instructions</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			startApp();
		</script>

</body>
<script type="text/javascript">
	$(function() {

		$("#location").html($("#locate").val());

		
		$("#enter-button").click(function() {
			var loc = $("#locate option:selected").val();
			localStorage.setItem("location", loc);
			$("#location").html($("#locate").val());
			location.reload();

		});
		loadData();

		function loadData() {
			var jsonM = ${jsonM};
			var jsonC = ${jsonC};

			for (var i = 0; i < jsonM.length; ++i) {
				var row = "<tr><td><a href='showList/" + jsonM[i].m_id + "'>"
						+ jsonM[i].m_name + " (" + jsonM[i].m_certification
						+ ") </a></tr></td>";
				$("#tab" + jsonM[i].m_language).append(row);
			}

			var loc = localStorage.getItem('location');
			$('#location').text(loc);

			for (var i = 0; i < jsonC.length; ++i) {
				if (loc == jsonC[i].c_location) {
					////alert(loc);
					var row = "<tr><td><a href='movieList/" + jsonC[i].c_id + "'>"
							+ jsonC[i].c_name
							+ " ("
							+ jsonC[i].c_location
							+ ") </a></tr></td>";
					$("#tabCinemas" + (i % 3 + 1)).append(row);
				}
			}
		}

	});
</script>
</html>


<!-- Search button not aligned
	css active/hover not working on buttons -->