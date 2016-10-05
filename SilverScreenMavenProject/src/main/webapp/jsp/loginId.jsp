<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="<c:url value="https://apis.google.com/js/api:client.js" />"></script>
<script src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" />"></script>
<title>Insert title here</title>
<link
	href="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/login.css" />"
	rel="stylesheet">
<script
	src="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" />"></script>
<script
	src="<c:url value="https://use.fontawesome.com/4db7f356f3.js" />"></script>
<script src="<c:url value="/resources/js/login.js" />"> </script>
<script src="<c:url value="/resources/js/jquery.cookie.js" />"> </script>
</head>
<body>
	<div class="container">
		<div class="row">
			<p class="text-center"><a href="#" class="btn btn-primary btn-lg" role="button" onclick="signOut();">Sign Out</a></p>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<p class="text-center"><a href="#" class="btn btn-primary btn-lg" role="button" data-toggle="modal" data-target="#login-modal">Sign In</a></p>
		</div>
	</div>
	<!-- END # BOOTSNIP INFO -->

	<!-- BEGIN # MODAL LOGIN -->
	<div class="col-md-offset-3 col-md-6 modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal_Head">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span class="glyphicon glyphicon-remove"></span>
					</button>
					<h4 class="ModalHead_Text">SIGN IN</h4>

				</div>

					
					<div id="div-forms">

						
						
							<div class="modal-body">
								<div class="row">
									<div class="col-md-offset-1 col-md-5">
								<div class="col-md-12" id="gSignInWrapper " style="padding-left: 0px; padding-right: 0px;">
									<div id="customBtn" class="customGPlusSignIn btn btn-block col-md-12">
										<span class="fa fa-google"> <span class="buttonText">Google</span></span>
									</div>
								</div>
							</div>
									<div class="col-md-5">
										<button class="btn btn-primary btn-block btn-social-icon btn-facebook" name="fButton" value="fButton" onclick = "fbLogin();"> 
											<span class="fa fa-facebook"></span> Facebook
										</button>
									</div>
									
									<div class="col-xs-offset-5 col-xs-2 col-sm-offset-5 col-sm-2 col-md-offset-5 col-md-2"><h2 class="ff">OR</h2></div>
									<form id="login_form" name="login_form"  method="Get">
									<div class="form-group col-md-offset-2 col-md-8">
									
										<input type="email" class="form-control " name="Uemail" id="Uemail" placeholder="Enter your email id" onblur="validateEmail();"><div ><p id="UemailWarning"></p></div>
									</div>
									<div class="form-group col-md-offset-2 col-md-8">
										
										<input type="password" class="form-control " name="Upassword" id="Upassword" placeholder="Enter your password" onblur="validatePwd();"><div ><p id="UpwdWarning"></p></div>
									</div>
									<div class="col-md-offset-2 col-md-8"><button class="btn btn-warning btn-md btn-block" onclick="loginUser();" >Login</button></div></form>
									<br/>
									<div class="col-md-offset-4 col-md-4 bt"><a href="#forgetPwd-modal" data-toggle="modal"  data-dismiss="modal" ><h6 style="text-align:center;">Forget Password</h6></a></div>
									<center><div class="col-md-offset-3 col-xs-12 col-sm-8 col-md-6 signup">Still Not Connected? <a id="su" href="#signup-modal" data-toggle="modal" data-dismiss="modal"><u>Sign Up</u> </a></div></center>
								</div>
							</div>
							
							</div>	
				</div>
			</div>
		</div>

		<!--Begin sign in form -->
		<div class="col-md-offset-3 col-md-6 modal fade" id="signup-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal_Head">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span class="glyphicon glyphicon-remove"></span>
					</button>
					<h4 class="ModalHead_Text">SIGN UP</h4>
				</div>
					<div id="div-forms2">
						
							<div class="modal-body">
								<div class="row">
									<form id="signup-form" name="signup_form"  method="Get">
									<div class="form-group col-md-offset-2 col-md-8">
									
										<input type="email" class="form-control " name="Semail" id="Semail" placeholder="Enter your email id" autocomplete="off" onblur="userNameValidation()"/><div ><p id="emailWarning"></p></div>
									</div>
									<div class="form-group col-md-offset-2 col-md-8">
										
										<input type="password" class="form-control " name="Spwd" id="Spwd" placeholder="Enter your password" autocomplete="off" onblur="pwdValidation()"/><div ><p id="pwdWarning"></p></div>
									</div>
									<div class="form-group col-md-offset-2 col-md-8">
										
										<input type="password" class="form-control " name="Sconfirm_pwd" id="Sconfirm_pwd" placeholder="Confirm password" autocomplete="off" onblur="cpwdValidation()"/><div ><p id="cpwdWarning"></p></div> <!-- disabled="disabled" -->
									</div>
									<div class="col-md-offset-2 col-md-8 bt"><button  id="sinupButton" class="btn btn-warning btn-md btn-block" name="siButton" id="siButton" onclick="checkAllFeilds();">Sign Up</button></div> <!--  -->
									</form>
									<center><div class="col-xs-12 col-sm-8 col-md-offset-3 col-md-6 signup">Already Connected? <a id="si" name="si" href="#login-modal" data-dismiss="modal" data-toggle="modal"><u>Sign In</u> </a></div></center>
								</div>
							</div>
						</div>
				</div>
			</div>
		</div>
			<div class="col-md-offset-3 col-md-6 modal fade" id="forgetPwd-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal_Head">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span class="glyphicon glyphicon-remove"></span>
					</button>
					<h4 class="ModalHead_Text">FORGET PASSWORD</h4>

				</div>
					<div id="div-forms3">
						<form id="signup-form">
							<div class="modal-body">
								<div class="row">
									<h4 style="text-align:center;" class="fontFam">Please enter your email address below.</h4>
									
									<div class="form-group col-md-offset-2 col-md-8">
									
										<input type="email" class="form-control " id="email" placeholder="Enter your email id">
									</div>
									<div class="col-md-offset-2 col-md-8 bt"><button type="submit" class="btn btn-warning btn-md btn-block">Send Instructions</button></div>
								</div>
							</div>
						</form>
						</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">startApp();</script>
		<script type="text/javascript">
		
			 </script>
	</body>
</html>