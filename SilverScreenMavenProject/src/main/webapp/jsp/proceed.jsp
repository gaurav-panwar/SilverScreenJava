<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Proceed</title>

<link
	href="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet">
<script src="<c:url value="https://apis.google.com/js/api:client.js" />"></script>
<script
	src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"/>"></script>
<script
	src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" />"></script>
<script
	src="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" />"></script>
<script
	src="<c:url value="https://use.fontawesome.com/4db7f356f3.js" />"></script>
	<script src="<c:url value="/resources/js/jquery.cookie.js" />">
	
</script>
<script src="<c:url value="/resources/js/login.js" />">
	
</script>
<link href="<c:url value="/resources/css/login.css" />">
	
<style type="text/css">
.back {
	padding: 0px;
	height: 100%;
	background-color: #f2f2f2;
}

.row {
	margin: 0;
}

.header {
	width: 100%;
	height: auto;
	background-color: #1f2533;
}

.movie_info {
	padding: 10px 20px 10px 50px;
	color: #49ba8e;
	width: 100%;
}

.movie_name {
	margin-top: 10px;
}

.movie_detail {
	margin-bottom: 0px;
}

.pay {
	height: 400px;
	background-color: transparent;
}

.summary {
	padding-top: 30px;
	background-color: white;
}

#timer {
	width: 50px;
	height: 50px;
	border: 2px solid #89B0AE;
	border-radius: 50%;
	text-align: center;
	background-color: #BEE3DB;
	color: #FAF9F9;
	font-weight: bold;
	padding-top: 10px;
}

.glyphicon.glyphicon-chevron-left {
	position: absolute;
	top: 37px;
	left: 10px;
	font-size: 30px;
	color: #f2f2f2;
}

button.accordion {
	background-color: #cccccc;
	color: #444;
	cursor: pointer;
	padding: 18px;
	width: 100%;
	border: none;
	text-align: left;
	outline: none;
	font-size: 15px;
	transition: 0.4s;
}

button.accordion.active, button.accordion:hover {
	background-color: #49ba8e;
}

button.accordion:after {
	content: '\02795';
	font-size: 13px;
	color: #777;
	float: right;
	margin-left: 5px;
}

button.accordion.active:after {
	content: "\2796";
}

div.panel {
	padding: 10 18px;
	margin-bottom: 0px;
	background-color: white;
	max-height: 0;
	overflow: hidden;
	transition: 0.6s;
	opacity: 0;
}

div.panel.show {
	opacity: 1;
	max-height: 500px;
	padding: 10px 20px, 10px, 20px;
}

.f {
	text-align: center;
	padding-top: 10px;
	padding-bottom: 10px;
	padding-left: 10px;
	padding-right: 10px;
}

.form-control {
	padding: 10px;
}

.placeholder {
	color: black;
}

.form-control {
	padding: 10px 10px 0px 10px;
	margin-top: 10px;
	margin-bottom: 10px;
}

.ff {
	text-align: center;
	margin-top: 0px;
	padding-top: 0px;
	font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
}

.total {
	background-color: orange;
	margin: 20px 0 20px 0;
}

.no_tickets {
	font-size: 15px;
}

@media ( max-width : 768px ) {
	h2 {
		font-size: 1.8em;
	}
	h4 {
		font-size: 1.4em;
	}
}

@media ( min-width :768px )and(max-width: 992px ) {
	h2 {
		font-size: 2.1em;
	}
	h4 {
		font-size: 1.7em;
	}
}

@media ( min-width : 992px )and(max-width: 1200px) {
	h2 {
		font-size: 2.4em;
	}
	h4 {
		font-size: 2em;
	}
}

@media ( min-width : 1200px ) {
	h2 {
		font-size: 2.6em;
	}
	h4 {
		font-size: 2.3 em;
	}
}
</style>

<script type="text/javascript">

$m=10;
$t=0;

function startTime()
{
	 
	$m=checkTime($m);
	$t=checkTime($t);
	document.getElementById("timer").innerHTML=$m+":"+$t;
	$m=parseInt($m);
	$t=parseInt($t);
	if($t==0&&$m==0)
	{
	$("#myModal").modal("show");
	
	}
	else{
		$t=$t-1;
		if($t<0)
			{
			$m=$m-1;
			$t=59;
			
			}
		var x=setTimeout(function(){startTime()},1000);
		
	}
	
	
}
	
	
	
	

function checkTime(i)
{
	if(i<10)
		i="0"+i;
	return i;
	
	}
function checkmail()
{
	var mail=document.getElementById("inputemail").value;
	var rege=/^[-a-z0-9~!$%^&*_=+}{\?]+(\.[-a-z0-9~!$%^&*_=+}{\?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;
	var result=rege.test(mail);
	if(result==false)
		{
		document.getElementById("errormail").innerHTML="invalid email";
		
		}
	else
	{
	document.getElementById("errormail").innerHTML="";
	}
	return result;
	}
	function checkphone()
	{
		var phone=document.getElementById("inputphone").value;
		var rege = /^[7-9][0-9]{9}$/;
		var result=rege.test(phone);
		if(result)
			{
			document.getElementById("errorphone").innerHTML="";
						}
		else
			{
			document.getElementById("errorphone").innerHTML="invalid phone";
			
			}
		return result;
	}
	
	function checkname()
	{
		
		 var name=document.getElementById("CardName").value;
		var rege=/^[a-z A-Z]+$/;
		var result=rege.test(name);
		
		if(result)
			{
			document.getElementById("paymenterror").innerHTML="";
			}
		else
			{
			document.getElementById("paymenterror").innerHTML="enter the field in correct format.";
			} 
	}
	function checkno()
	{
		
		 var name=document.getElementById("CardNo").value;
		var rege=/[0-9]{10}$/;
		var result=rege.test(name);
		
		if(result)
			{
			document.getElementById("paymenterror").innerHTML="";
			}
		else
			{
			document.getElementById("paymenterror").innerHTML="enter the field in correct format.";
			} 
	}
	function checkcvv()
	{
		
		 var name=document.getElementById("CvvNo").value;
		var rege=/[0-9]{3}$/;
		var result=rege.test(name);
		
		if(result)
			{
			document.getElementById("paymenterror").innerHTML="";
			}
		else
			{
			document.getElementById("paymenterror").innerHTML="enter the field in correct format.";
			} 
	}
	
	function checkall()
	{
		if(checkname()&&checkno()&&checkcvv())
			document.getElementById("submitbutton").disabled=false;
			
	}
	
	

</script>

</head>
<body onbeforeunload="//alert('function alrt WORKS !!!!')">

	<div class="container-fluid back">
		<div class="header">
			<span><a class="glyphicon glyphicon-chevron-left" href="#"
				style="text-decoration: none;"></a></span>
			<div class="movie_info">
				<h4 class="movie_name"></h4>
				<p class="movie_detail"></p>

			</div>

		</div>
		<div class="row ">
			<br>
			<div class="col-xs-8 col-sm-8 col-md-8 pay">
				<button class="accordion">Share your Contact</button>
				<div class="panel">
				
					<form class="form-inline f" action="#">
					<p id="errormail" style="font-weight: bold;color:red;"></p>
						<input class="form-control" type="email" name="emailId" id="inputemail"
							placeholder="Email Address" onblur="checkmail()"> <input class="form-control" id="inputphone"
							type="number" name="mNo" placeholder="Mobile No."
							maxlength="10" onblur="checkphone()">
							<p id="errorphone" style="font-weight: bold;color:red;"></p>
						<button class="btn btn-danger" id="inputsubmit" type="button">SUBMIT</button>
					</form>
					<p id=submitAlert></p>
					<div class="or">
						<div
							class="col-xs-offset-5 col-xs-2 col-sm-offset-5 col-sm-2 col-md-offset-5 col-md-2">
							<h2 class="ff" id="or">OR</h2>
						</div>
						<div
							class=" text-center col-xs-offset-3 col-xs-6 col-sm-offset-3 col-sm-6 col-md-offset-3 col-md-6 btn btn-danger"
							style="margin-bottom: 10px;" type="button" id="login" data-target="#login-modal" data-toggle="modal">LOGIN</div>
					</div>

				</div>

				<button class="accordion">Payment Option</button>
				<div class="panel">
				<p id="paymenterror"></p>
					<form class="f col-md-9" action="databasecommit">
						
						<div class="form">
							<input class="form-control col-md-offset-2 col-md-8" type="text"
								id="CardNo" name="CardNo" placeholder="Enter Your Card Number" required onblur="checkno()">
						</div>
						<div class="form">
							<input class="form-control col-md-offset-2 col-md-8" type="text" onblur="checkname()"
								id="CardName" name="CardName" placeholder="Name On The Card" required >
						</div>
						<div class="form">
							<input class="form-control col-md-offset-2 col-md-8" type="num" 
								maxlength="5" id="CardMonth" name="CardMonth"
								placeholder="Expiry Date(MM/YY) " required >
						</div>
						<div class="form">
							<input class="form-control col-md-offset-2 col-md-8" type="num" onblur="checkcvv()";
								maxlength="3" id="CvvNo" name="CvvNo" placeholder="CVV" required>
						</div>
						<input type="hidden" name="ms_id" value="" id="ms_id"> 
						<input type="hidden" name="seats" value="" id="seats">
						<input type="hidden" name="hiddenemail" value="" id="hiddenemail"> 
						<input type="hidden" name="hiddenphone" value="" id="hiddenphone">
						
						<div class="form"> 
							<input class="col-md-offset-4 col-md-8 btn btn-danger" id="submitbutton"
								type="submit" >

						</div>

					</form>
				</div>
				<script type="text/javascript">
									var acc = document.getElementsByClassName("accordion");
									var i;

									for (i = 0; i < acc.length; i++) {
										acc[i].onclick = function(){
											this.classList.toggle("active");
											this.nextElementSibling.classList.toggle("show");
										}
									}
								</script>

			</div>
			<div class="col-xs-4 col-sm-4 col-md-4 summary">
				<div class="row">
					<div class="col-md-8">
						<h3>ORDER SUMMARY</h3>
					</div>
					<br>
					<div class="col-md-8 ">
						<b><h4 class="movie_name">Movie Name</h4></b>
					</div>
					<div class="col-md-8 ">
						<h6 id="abt_movie">Language, format</h6>
					</div>
					<span class="col-md-4 text-center no_tickets">
				</div>
				</span>
				<div class="col-md-8" id="cinema_name">
					<h6>Cinema Name</h6>
				</div>
				<div class="col-md-8 ">
					<h5 id="seat_alloted">
						A1, B1, C1<br>Date<br>Time
					</h5>
				</div>
				<div class="separator"></div>
				<br>
				<div class="col-md-9">Sub Total</div>
				<div class="col-md-3 ticket_A"></div>
				<br>
				<div class="col-md-9">+Internet Handling Fees</div>
				<div class=" col-md-3 ">Re. 25.6</div>
				<div class="col-md-12 total">
					<h5 class="col-md-6 ">Amount Payable</h5>
					<h4 class="col-md-6 text-center payable"></h4>
				</div>
				<div class="col-xs-4">
				</div>
				<div class="col-xs-5">

					<div id="timer"></div>
					<br>
					<div class="modal fade" id="myModal" role="dialog"
						data-backdrop="static" data-keyboard="false">
						<div class="modal-dialog">


							<div class="modal-content">
								<div class="modal-header" style="font-weight:bold;background-color: #101935; color:#F2FDFF ;text-align: center;">
									<div class="modal-title" >
									<h2  style="padding-bottom: 0;	 ">Sorry,Your time is up</h2><br>
										
									</div>
								</div>
								<div class="modal-body">
									<h4 style="text-align: center;">Click the following button to redirect to prevoius
										page</h4/>
									<div class="col-xs-12">
									<div class="col-xs-8"></div>
									<a class="btn btn-danger col-xs-4" id= goback>Movies Page</a>
									</div>
								</div>

							</div>

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
			window.onbeforeunload = function() {
			    return "Dude, you can't";}
			
			$("#inputsubmit").click(function(){
				var x=$("#inputemail").val();
				var y=$("#inputphone").val();
				
				if(checkmail()&&checkphone())
					{
					$("#hiddenemail").val($("#inputemail").val());
					$("#hiddenphone").val($("#inputphone").val());
					$("#errorphone").text("Details validated");
					$('#inputsubmit').hide();
					}
				
				
			});
			
								window.onload = function() {
									startTime();
									var x=$.cookie("userCookie");
									if(x!=null)
										{
										$("#login").hide();
										$("#or").hide();
										
										
										}
											$("#ms_id").val(${ms_id});
											$("#seats").val("${seats}");
									$.get("showMovieShowDetail/"+${ms_id},function(data,status){
										
										//alert(data);
										data=JSON.parse(data);
										$.get("/SilverScreenMavenProject/getUser",function(data,status){
											data=JSON.parse(data);
											var v=data["number"];
											console.log(v);
											$("#inputemail").val(data["email"]);
											$("#inputphone").val(v);
											
											if(checkmail()&&checkphone())
											{
											$("#hiddenemail").val($("#inputemail").val());
											$("#hiddenphone").val($("#inputphone").val());
											}
											
										});
										var  movieName=data["movie"]["m_name"];
										
										var format= data["movie"]["m_format"];
										var lang= data["movie"]["m_language"];
										var x = new Date(
												data["ms_timestamp"]);
										var t = x.getHours();
										t += ":";
										t += x.getMinutes();
										var time=t;
										var date= x.toDateString();
										var day;
										var cinemaName=data["audi"]["cinema"]["c_name"]+" , "+data["audi"]["cinema"]["c_location"];
										var noTicket=${length};
										var seatAlloted="A5 A6";
										var sa=parseInt(data["ms_price"])*parseInt(${length});
                                        $(".ticket_A").text("Rs."+sa);
                                        sa+=25.60;
                                        $(".payable").text("Rs."+sa);
										$(".movie_name").text(movieName);
										$(".movie_detail").html(lang+' | '+format+' | '+date+','+time+'<br>'+cinemaName);
										$("#abt_movie").text(lang+", "+format);
										$("#cinema_name").html(cinemaName);
										$(".no_tickets").html(noTicket+"<br><b>Tickets</b>");
										$("#seat_alloted").text("${seats}");
										$('#goback').attr('href', '/SilverScreenMavenProject/showList/'+data["movie"]["m_id"])
										
									});
									


								};


							</script>
		</div>
	</div>

</body>
	
</html>