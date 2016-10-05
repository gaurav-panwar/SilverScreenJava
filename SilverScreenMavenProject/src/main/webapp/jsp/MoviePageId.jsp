<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Movie</title>
<link
	href="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet">
<script
	src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" />"></script>
<script src="<c:url value="https://apis.google.com/js/api:client.js" />"></script>
	<script src="<c:url value="/resources/js/login.js" />">
	
</script>
<script
	src="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" />"></script>
<link href="<c:url value="/resources/css/MoviePageIdcss.css" />"
	rel="stylesheet">
<script
	src="<c:url value="https://use.fontawesome.com/4db7f356f3.js" />"></script>

<script src="<c:url value="/resources/js/jquery.cookie.js" />"></script>
	<link rel="stylesheet" type="text/css"
	href="<c:url value='/resources/css/modal.css' />">
	<link rel="stylesheet" type="text/css"
	href="<c:url value='/resources/css/bookinghistory.css' />">
	
<link href="<c:url value="/resources/css/login.css" />">
<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("#location").html($("#locate").val());

		$("#enter-button").click(function() {
			var loc = $("#locate option:selected").val();
			localStorage.setItem("location", loc);
			$("#location").html($("#locate").val());
			location.reload();

		});

		$.get("/SilverScreenMavenProject/showMovie/"+${m_id},function(data,status){
			data=JSON.parse(data);
			var x = data["m_cover"];
			$("#video-back #back").attr("src",x);
			/* $("#video-back").css("background-size","cover"); */
			var poster =data["m_poster"];
			$("#poster img").attr("src", poster);
			var moviename = data["m_name"];
			$(".moviename").text(moviename);
			var genre = data["m_certification"];
			$(".genre").text(genre);
			var lang = data["m_language"];
			$(".lang").text(lang);
			var format = data["m_genre"];
			$(".format").text(format);
			var jsdate = new Date(data["m_date"]);
			var release=jsdate.getUTCDate();
			release+="/";
			release+=jsdate.getUTCMonth()+1;
			release+="/";
			release+=jsdate.getUTCFullYear();
			
			$(".release").text(release);
			var jstime = new Date(data["m_duration"]);
			var duration=jstime.getHours();
			duration+="hrs ";
			duration+=jstime.getMinutes();
			duration+="Mins";
			var d = new Date();
			if(d <= jsdate){
				$("#movieShows").hide();
			}
		
			$(".duration").text(duration);
			var summary = data["m_synopsis"];
			$(".summary").text(summary);
			var array=data["review"];
			var sum=0;
			for(var i=0;i<array.length;i++)
				{sum+=parseInt(array[i]["rating"]);}
			
			var userrating = sum/array.length;
			userrating+=" stars";
			$(".userrating").text(userrating);
			
				
				var url = data["m_trailer"];
                  
			$("#trailerModal").on('hide.bs.modal', function() {
				$("#cartoonVideo").attr('src', '');
			});

			$("#trailerModal").on('show.bs.modal', function() {
				$("#cartoonVideo").attr('src', url);
			});
			
			var reviews = ("<div class='col-xs-12'></div>");
			var number = data["review"];
			
			
			for (var i = 0; i < number.length; i++) {
				
				
				var iuser = ("<div class='col-xs-6 reviewborder'>"+number[i]["user"]["name"]+"</div>");
				reviews = $(reviews).append(iuser);
				var rating = ("<div class='col-xs-6 reviewborder'>Rating:"+number[i]["rating"]+" Stars</div>");
				reviews = $(reviews).append(rating);
				var rawreview = ("<div class='col-xs-12 reviewborderend'>"+number[i]["review"]+"</div>");
				reviews = $(reviews).append(rawreview);
				$("#userreview").append(reviews);
			}
			
			var total=data["cast"];
			var l=total.length;
			
			var t=l%3;
			l=l-t;
			l=l/3;
			
			for (var m = 0; m <=l; m++) {
				var path = "/SilverScreenMavenProject/resources/images/user.png";
				$(".carousel-indicators")
						.after(
								"<li data-target='#carousel-example-generic' data-slide-to=\""+m+"\"></li>");
				var inside = ("<div class='col-xs-12 item'></div>")
				if(m==l)
					{

					for (var n = 0; n < t; n++)
						inside=$(inside).append("<div class='col-xs-3 item' ><img class='col-xs-12 img-circle' src='"+path+"' alt='"+m+"'><span class='col-xs-12' style='font-size:1.4vw;'>"+total[m*3+n]["cast_name"]+"</span><span class='col-xs-12' style='font-size:1.4vw;'>("+total[m*3+n]["cast_position"]+")</span></div><div class='col-xs-1'></div>");
					
					}
				else
					{

					for (var n = 0; n < 3; n++)
						inside=$(inside).append("<div class='col-xs-3 item'><img class='col-xs-12 img-circle' src='"+path+"' alt='"+m+"'><span class='col-xs-12' style='font-size:1.4vw;'>"+total[m*3+n]["cast_name"]+"</span><span class='col-xs-12' style='font-size:1.4vw;'>("+total[m*3+n]["cast_position"]+")</span></div><div class='col-xs-1'></div>");
					}
				$(".carousel-inner").append(inside);
			}
			
			$('#movieShows').attr("href", "/SilverScreenMavenProject/showList/" + data['m_id']);
				
			
			
			$(".carousel-indicators li:first").addClass("active");
			$(".carousel-inner .item:first").addClass("active");
			$('.carousel').carousel();
			
			
		});

		
		
		$(".rating input:radio").attr("checked", false);
		$('.rating input').click(function() {
			$(".rating span").removeClass('checked');
			$(this).parent().addClass('checked');
		});

		$('input:radio').change(function() {
			var userRating = this.value;
			////alert(userRating);
		});
		
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
</script>


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
						<img id = phoneIcon src='<c:url value="/resources/images/phone-icon.png"/>'>
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
	<div class="container-fluid">
		<div class="page-header">
			<div class="video-container">
					<div id="video-back" 
						style="position: relative;">
						<img src="" class="img-responsive" id="back">
					</div>
					<div id=play style="position: absolute;" data-toggle="modal" data-target="#trailerModal">
						<img src="<c:url value="/resources/images/play.png"/>"
							class="img-responsive">
					</div>
				<div id="trailerModal" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content" id=trailercontent>
							<div class="modal-header" id=trailerhead>
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">×</button>
								<h4 class="modal-title" >TRAILER</h4>
							</div>
							<div class="modal-body" >
								<iframe id="cartoonVideo" width="560" height="315" src=""
									frameborder="0" allowfullscreen></iframe>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<div class="row">
			<div class="col-xs-2 leftside">
				<div id="poster">
					<img alt="poster image" src="">
				</div>
			</div>
			<div class="col-xs-7 middlemain">
				<span class="col-xs-12 main moviename"> </span>
				<div class="col-xs-12 main">
					<span class="col-xs-1 genre"></span> <span class="col-xs-2 lang"
						style="font-weight: bold"></span> <span class="col-xs-9"></span>
				</div>

				<div class="col-xs-12 main">
					<span class="col-xs-2 format"> </span>
				</div>
				<div class="col-xs-12 main">
					<div class="col-xs-1" style="text-align: right">
						<i class="fa fa-calendar" style="font-size: 150%"></i>
					</div>
					<div class="col-xs-3 release" style="font-weight: bold; padding: 0"></div>
					<div class="col-xs-1" style="text-align: right">
						<i class="fa fa-clock-o" style="font-size: 150%"></i>
					</div>
					<div class="col-xs-3 duration"
						style="font-weight: bold; padding: 0"></div>

				</div>
				<div class="col-xs-12 ratingstab main">

					<div class="col-xs-6">
						<span class="col-xs-6" style="font-size: 1.5vw; text-align: right">User
							Rating:</span> <span class="col-xs-6 userrating"
							style="text-align: left;"></span>
					</div>
					<div class="col-xs-6">
						<div class="col-xs-10 rating">
							<span><input type="radio" name="rating" id="str5"
								value="5"><i class="fa fa-star "></i></span> <span><input
								type="radio" name="rating" id="str4" value="4"><i
								class="fa fa-star "></i></span> <span><input type="radio"
								name="rating" id="str3" value="3"><i class="fa fa-star "></i></span>
							<span><input type="radio" name="rating" id="str2"
								value="2"><i class="fa fa-star "></i></span> <span><input
								type="radio" name="rating" id="str1" value="1"><i
								class="fa fa-star "></i></span>
						</div>

					</div>


				</div>
				<div class="col-xs-12">
					<ul class="nav nav-tabs movie-nav">
						<li class="active"><a data-toggle="tab" href="#summary"
							style="font-size: 1.5vw;">Summary</a></li>
						<li><a data-toggle="tab" href="#userreview"
							style="font-size: 1.5vw;">User Review</a></li>
						<li><a data-toggle="tab" href="#castandcrew"
							style="font-size: 1.5vw;">Cast And Crew</a></li>

					</ul>

					<div class="tab-content movieContent">
						<div id="summary" class="tab-pane fade in active tab-pane-movie">
							<h1 style="font-size: 2vw;margin: 10px;">SUMMARY</h1>
							<div class="summary" style="font-size: 1.5vw; margin: 10px;"></div>
						</div>
						<div id="userreview" class="tab-pane fade in tabs-movie tab-pane-movie">
							<h1 style="font-size: 3vw;">User Review</h1>
						</div>
						<div id="castandcrew" class="tab-pane fade in tab-pane-movie ">
							<h1 style="font-size: 3vw;">Cast & Crew</h1>
							<div id="carousel-example-generic" class="carousel slide"
								data-ride="carousel">

								<ol class="carousel-indicators"></ol>

								<div class="carousel-inner"></div>

								<a class="left carousel-control"
									href="#carousel-example-generic" data-slide="prev"> <span
									class="glyphicon glyphicon-chevron-left"></span>
								</a> <a class="right carousel-control"
									href="#carousel-example-generic" data-slide="next"> <span
									class="glyphicon glyphicon-chevron-right"></span>
								</a>
							</div>
						</div>

					</div>
				</div>
			</div>

			<div class="col-xs-3 rightside">


				<div class="col-xs-12 top">
					<br>
					<a role= button id=movieShows class=" col-xs-12 btn btn-primary"
						style="margin: 2px; font-size: 2vw;">BUY TICKETS</a>
				</div>
			</div>

		</div>
	</div>
	
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
</html>