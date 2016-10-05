<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Movies</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="<c:url value='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css' />">
</script>
<script src="<c:url value="https://apis.google.com/js/api:client.js" />"></script>
<script
	src="<c:url value= 'https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js' />"></script>
<script
	src="<c:url value='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>
<script
	src="<c:url value='https://use.fontawesome.com/4cac0da64a.js' />"></script>

<link rel="icon"
	href="<c:url value='/resources/images/silverscreen-logo-white.png' />">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/resources/css/MoviesPage.css' />">
<script type="text/javascript"
	src="<c:url value='/resources/js/MoviesPage.js' />"></script>
	<script src="<c:url value="/resources/js/jquery.cookie.js" />"></script>
	<link rel="stylesheet" type="text/css"
	href="<c:url value='/resources/css/modal.css' />">
	<script src="<c:url value="/resources/js/login.js" />">
	
</script>
<link href="<c:url value="/resources/css/login.css" />">

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
	<div class="container-fluid">
		<!-- nav bar with links -->
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
					<li><a href="/SilverScreenMavenProject/homepage"><span
							class="glyphicon glyphicon-home"></span></a></li>
					<li class="active"><a href="/SilverScreenMavenProject/moviesPage">Movies</a></li>
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
				src="<c:url value='/resources/images/silverscreen-logo-white.png' />"
				class="pull-left">

			<form class="col-sm-9 col-sm-offset-2 col-xs-9 col-xs-offset-2"
				role="search" name="searchForm" style="width: 60%" action="/SilverScreenMavenProject/searchBox">
				<div class="input-group" style="display: block;">
					<a href="/SilverScreenMavenProject/searchBox"><input type="search" class="form-control"
						placeholder="Find Movies or Cinemas you like." name="srch-term"
						id="searchBox"></a>
					<div class="input-group-btn">
						<button class="btn btn-default" id="searchButton" type="submit">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
			</form>
		</header>
		<!-- logo sec finish -->

		<!-- Carousel -->
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox" id='carousel-list'>

			</div>

			<!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" role="button"
				data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel" role="button"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>


	<main> <br>
	<br>
	<p class="col-sm-1 col-sm-offset-5" id='movieText'>
		<b>MOVIES</b>
	</p>
	<div class="clearfix"></div>
	<br>
	<br>

	<div class="col-sm-4 col-sm-offset-4">
		<button type='button'
			class="btn-default pull-left btn-ns-filter active"
			id='btn-NowShowing'>
			<b>NOW SHOWING</b>
		</button>
		<button type='button' class="btn-default pull-left btn-ns-filter"
			id='btn-ComingSoon'>
			<b>COMING SOON</b>
		</button>
	</div>
	<div class="clearfix"></div>
	<br>
	<br>
	<hr>

	</main>

	<!-- Filters -->
	<main id='main-filters'>
	<div class="col-filters col-sm-2 pull-left"
		style="background-color: white;">
		<table>
			<tr>
				<th style="font-size: 20px;">Filter By</th>
			</tr>
		</table>
		<hr>

		<table id='tab-Lang-Filter' class='tab-filters'>
			<tr>
				<th style="text-align: center;">LANGUAGE</th>
			</tr>
			<tr>
				<td><input type="checkbox" name="lang-filter" value="Hindi"
					id='Hindi-filter'> <label for="Hindi-filter">&nbsp;
						Hindi</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="lang-filter" value="English"
					id='English-filter'> <label for="English-filter">&nbsp;
						English</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="lang-filter" value="Punjabi"
					id='Punjabi-filter'> <label for="Punjabi-filter">&nbsp;
						Punjabi</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="lang-filter" value="Tamil"
					id='Tamil-filter'> <label for="Tamil-filter">&nbsp;
						Tamil</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="lang-filter" value="Telugu"
					id='Telugu-filter'> <label for="Telugu-filter">&nbsp;
						Telugu</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="lang-filter" value="Bengali"
					id='Bengali-filter'> <label for="Bengali-filter">&nbsp;
						Bengali</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="lang-filter" value='Haryanvi'
					id='Haryanvi-filter'> <label for="Haryanvi-filter">&nbsp;
						Haryanvi</label></td>
			</tr>
		</table>

		<br>
		<table id='tab-Genre-Filter' class='tab-filters'>
			<tr>
				<th style="text-align: center;">GENRE</th>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter" value="Action"
					id='Action-filter'> <label for="Action-filter">&nbsp;
						Action</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter"
					value="Adventure" id='Adventure-filter'> <label
					for="Adventure-filter">&nbsp; Adventure</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter"
					value="Animation" id='Animation-filter'> <label
					for="Animation-filter">&nbsp; Animation</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter" value="Comedy"
					id='Comedy-filter'> <label for="Comedy-filter">&nbsp;
						Comedy</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter" value="Crime"
					id='Crime-filter'> <label for="Crime-filter">&nbsp;
						Crime</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter" value="Drama"
					id='Drama-filter'> <label for="Drama-filter">&nbsp;
						Drama</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter" value="Fantasy"
					id='Fantasy-filter'> <label for="Fantasy-filter">&nbsp;
						Fantasy</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter" value="Family"
					id='Family-filter'> <label for="Family-filter">&nbsp;
						Family</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter" value='Horror'
					id='Horror-filter'> <label for="Horror-filter">&nbsp;
						Horror</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter" value="Romance"
					id='Romance-filter'> <label for="Romance-filter">&nbsp;
						Romance</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter" value="Sci-fi"
					id='Sci-Fi-filter'> <label for="Sci-Fi-filter">&nbsp;
						Sci-Fi</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="genre-filter" value='Thriller'
					id='Thriller-filter'> <label for="Thriller-filter">&nbsp;
						Thriller</label></td>
			</tr>
		</table>

		<br>
		<table id='tab-Format-Filter' class='tab-filters'>
			<tr>
				<th style="text-align: center;">FORMAT</th>
			</tr>
			<tr>
				<td><input type="checkbox" name="format-filter" value="2D"
					id='2D-filter'> <label for="2D-filter">&nbsp; 2D</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="format-filter" value="3D"
					id='3D-filter'> <label for="3D-filter">&nbsp; 3D</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="format-filter" value="4DX"
					id='4DX-filter'> <label for="4DX-filter">&nbsp; 4DX</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="format-filter" value="IMAX"
					id='IMAX-filter'> <label for="IMAX-filter">&nbsp;
						IMAX</label></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="format-filter" value="IMAX-3D"
					id='IMAX-3D-filter'> <label for="IMAX-3D-filter">&nbsp;
						IMAX-3D</label></td>
			</tr>
		</table>
		<br>
	</div>
	</main>
	<!-- Filters End -->

	<!-- Movies List -->
	<main id='main-NowShowing' class='movies-list col-sm-offset-2'>
	</main>


	<main id='main-ComingSoon' class='movies-list col-sm-offset-2'>
	</main>



	<main id='main-TopMovies'>
	<div class="clearfix"></div>
	<br>
	<br>
	<hr>
	<div class="top-movies col-sm-3" style="background-color: white;">
		<span class='col-sm-offset-2'
			style="border-bottom: 2px solid #cc0000; font-size: 20px;"><b>TOP
				MOVIES</b></span>
		<div class="clearfix"></div>

		<br>
		<ul id='topMovies' style="list-style: none;">
		</ul>
	</div>
	</main>

	<main id='main-NextChange' class='col-sm-offset-3'> <span
		class="col-sm-offset-3"
		style="border-bottom: 2px solid #cc0000; font-size: 20px;"><b>NEXT
			CHANGE</b></span> <br>
	</main>
	<div class="clearfix"></div>
	<br>
	<br>


	<!-- Footer -->
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
	<div id="trailerModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">TRAILER</h4>
				</div>
				<div class="modal-body">
					<iframe id="trailerVideo" width="560" height="315" src=""
						frameborder="0" allowfullscreen></iframe>
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

										<input type="text" class="form-control " name="Upassword"
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
				var jsonNS = ${jsonNS};
				var jsonCS = ${jsonCS};
				var cnt = 0, cnc = 0;
				var mov_card = "";
				var row = "";
				var cr_item = "";

				for (var i = 0; i < jsonNS.length; ++i) {
					cnt++;
					mov_card = createMovieCard(jsonNS[i], cnt);
					$('#main-NowShowing').append(mov_card);
					if (cnt % 2 == 0) {
						row = createRow(jsonNS[i]);
						$('#topMovies').append(row);
					}
				}

				for (var i = 0; i < jsonCS.length; ++i) {
					cnt++;
					mov_card = createMovieCard_CS(jsonCS[i], cnt);
					$('#main-ComingSoon').append(mov_card);
					if (cnc < 3 /* && cnt%3 == 0 */) {
						cnc++;
						$('#main-NextChange').append(mov_card);
					}

					cr_item = createCarouselItem(jsonCS[i], cnc);
					console.log(cr_item);
					$('#carousel-list').append(cr_item);
				}
			}

			function createMovieCard(data, cnt) {
				var mov_card = "<div class='movie-tile col-sm-3 mv-lang-" + data.m_language + " mv-gen-" + data.m_genre + " mv-form-"+ data.m_format + "' id='mv-tl-" + data.m_id +"'>"
						+ "<img src='<c:url value='" + data.m_poster + "' />' alt="
						+ data.m_name
						+ "class='mv-icon' style='height:375px; width:260px;'>"
						+ "<br><div class='hover-btn'>"
						+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
						+ " onclick='showTrailer(this);'"
						+ "id='mv-sp-"
						+ data.m_trailer
						+ "'></span>"
						+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + data.m_id + "' >"
						+ "<span class='glyphicon glyphicon-info-sign'></span></a>"
						+ "</div>"
						+ "<span id='mov-name'><b>"
						+ data.m_name
						+ " ("
						+ data.m_certification
						+ ") "
						+ "</b></span><br>"
						+ "<span id='mov-lang'>"
						+ data.m_language
						+ " ("
						+ data.m_format
						+ ") "
						+ "</span><br>"
						+ "<span id='mov-genre'>"
						+ data.m_genre
						+ "</span><br>"
						+ "<a href='" + "showList/" + data.m_id + "'> <button class='btn-book' type='button'>BOOK NOW</button></a>"
						+ "</div>";

				return mov_card;
			}

			function createMovieCard_CS(data, cnt) {
				var mov_card = "<div class='movie-tile col-sm-3 mv-lang-" + data.m_language + " mv-gen-" + data.m_genre + " mv-form-"+ data.m_format + "' id='mv-tl-" + data.m_id +"'>"
						+ "<img src='<c:url value='" + data.m_poster + "' />' alt="
						+ data.m_name
						+ "class='mv-icon' style='height:375px; width:260px;'>"
						+ "<br><div class='hover-btn'>"
						+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
						+ " onclick='showTrailer(this);'"
						+ "id='mv-sp-"
						+ data.m_trailer
						+ "'></span>"
						+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + data.m_id + "' >"
						+ "<span class='glyphicon glyphicon-info-sign'></span></a>"
						+ "</div>"
						+ "<span id='mov-name'><b>"
						+ data.m_name
						+ " ("
						+ data.m_certification
						+ ") "
						+ "</b></span><br>"
						+ "<span id='mov-lang'>"
						+ data.m_language
						+ " ("
						+ data.m_format
						+ ") "
						+ "</span><br>"
						+ "<span id='mov-genre'>"
						+ data.m_genre + "</span><br>" + "</div>";

				return mov_card;
			}

			$("#trailerModal").on('hide.bs.modal', function() {
				$("#trailerVideo").attr('src', '');
			});

			function createRow(data) {
				var row = "<li><i class='fa fa-film'></i>"
						+ "<a href='" + "/SilverScreenMavenProject/movieDetails/" + data.m_id + "'>"
						+ "&nbsp;" + data.m_name + "</a></li>";
				return row;
			}

			function createCarouselItem(data, cnt) {
				var it = "<div align='center' class='item ";
				if (cnt == 1)
					it += "active";

				it += "'>"
						+ "<a href='" + "/SilverScreenMavenProject/movieDetails/" + data.m_id + "'>"
						+ "<img src='<c:url value='" + data.m_poster + "' />'"
						+ " alt='" + data.m_name + "' class='Carousel-Image'>"
						+ "</a>" + "</div>";

				return it;
			}
			
			$("#resetBtn").click(function() {
				document.getElementById('resultData').style.display = "none";
				document.getElementById('detailsForm').style.display = "block";
				document.getElementById('email').value ="";
				document.getElementById('num').value ="";
			})

			$('#formSubmit').click(function () {
			    	$.ajax({
			    		url : '/SilverScreenMavenProject/getDetails',
			    		data : {
			    			email : $('#email').val(),
			    			number : $('#num').val()
			    		},
			    		success : function(responseText) {
			    			responseText=JSON.parse(responseText);
			    			var date = new Date(responseText.movie_show.ms_timestamp).getDate() + new Date(responseText.movie_show.ms_timestamp).getMonth() + new Date(responseText.movie_show.ms_timestamp).getFullYear();
			    			var time = new Date(responseText.movie_show.ms_timestamp).getHours() + new Date(responseText.movie_show.ms_timestamp).getMinutes();
			    			$("#b_id").text(responseText.bd_id);
							$("#cinema_name").text(responseText.movie_show.audi.cinema.c_name);
							$("#audi_num").text(responseText.movie_show.audi.a_number);
							$("#seats_booked").text(responseText.seats_booked);
							$("#dateOfShow").text(date);
							$("#timeOfShow").text(time);
							$("#pricePerShow").text(responseText.movie_show.ms_price);
							
							document.getElementById('resultData').style.display = "block";
							document.getElementById('detailsForm').style.display = "none";
			    		}
			    	});
			})

		});
		
		function showTrailer(tmp) {
			var str = tmp.id;
			var id = str.substring(6);
			
			console.log("Running " + id);
			
			$('#trailerVideo').attr("src", id);
			$('#trailerModal').show();
		}
	</script>

</body>
</html>