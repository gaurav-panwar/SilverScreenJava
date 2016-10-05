
	var googleUser = {};
	var startApp=function() {
	    gapi.load('auth2', function(){
	      auth2 = gapi.auth2.init({
	        client_id: '99674760653-bfn6755ek0d3h657e9r7ltad7u4reg02.apps.googleusercontent.com',
	        cookiepolicy: 'single_host_origin',
	        scope: 'profile email'
	      });
	      attachSignin(document.getElementById('customBtn'));
	    });
	  };
	  function attachSignin(element) {
	    auth2.attachClickHandler(element, {},
	        function(googleUser) {
	         var name=googleUser.getBasicProfile().getName();
	          var email=googleUser.getBasicProfile().getEmail();
	          $.ajax({
	   			url : "login_google",
	   			type : "GET",
	   			contentType : "application/json; charset=utf-8",
	   			data : { name, email },
	   			success: function(){
         			//alert($.cookie("userCookie"));
         			location.reload();
         		},
	   			
	   			});
	        }, function(error) {
	          //alert(JSON.stringify(error, undefined, 2));
	        });
	  }
	 
	  function fbLogin(){
		  window.fbAsyncInit = function() {

		      FB.init({
		        appId      : '1753580014930280', // App ID
		        status     : true, // check  status
		        cookie     : true, // enable cookies to allow the server to access the session
		        oauth      : true,
		        xfbml      : true  // parse XFBML
		      });

		    FB.login(function (response) {

		            if (response.status === "connected") {


		                      FB.api('/me', {fields: 'id,name,email,gender'}, function (response) {

		                             var name = response.name;
		                             var email=response.email;
		                            $.ajax({
		                     			url : "login_google",
		                     			type : "GET",
		                     			contentType : "application/json; charset=utf-8",

		                     			data : {
		                     				name, email
		                     			},
		                     		success:function(){
		                     			//alert($.cookie("userCookie"));
		                     			location.reload();
		                     		}
		                     		});
		                            
		                            
		                       });
		                      $("#login-modal").modal("hide");

		                    } else if (response.status === "not_authorized") {
		                    }
		                },
		                {
		                    scope: 'user_hometown, user_location, user_photos, user_about_me, email, publish_actions, public_profile'
		                }
		            );


		    
		      };

		      (function(d){
		       var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
		       if (d.getElementById(id)) {return;}
		       js = d.createElement('script'); js.id = id; js.async = true;
		       js.src = "//connect.facebook.net/en_US/all.js";
		       ref.parentNode.insertBefore(js, ref);
		      }(document));
		}
	  
	  function logout() {
		  window.fbAsyncInit = function() {

		      FB.init({
		        appId      : '1753580014930280', // App ID
		        status     : true, // check login status
		        cookie     : true, // enable cookies to allow the server to access the session
		        oauth      : true,
		        xfbml      : true  // parse XFBML
		      });

		      FB.getLoginStatus(function (response) {
		          if (response.status === 'connected') {
		        	  FB.logout(function(response) {
		        	        console.log("sign out");
		        	        console.log(response.email);
		        	      });
		          }
			  });
		      };

		      (function(d){
		       var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
		       if (d.getElementById(id)) {return;}
		       js = d.createElement('script'); js.id = id; js.async = true;
		       js.src = "//connect.facebook.net/en_US/all.js";
		       ref.parentNode.insertBefore(js, ref);
		      }(document)); 
	  }
function userNameValidation() {
	var pattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,3}$/;
	var username =$("#Semail").val();
	console.log(username);
	if (username.match(pattern)) {
		console.log("match");
		moo(function(data){
			if (data === "exist") {
				console.log(data);
				$("#emailWarning").text("EmailId already exist");
				return false;
				} 
			else {
					$("#emailWarning").text("");
					return "true";
				}
			    
		});
	}else{
		$("#emailWarning").text("invalid emailid");
		return false;
	}
		
	function moo(data1){
		console.log("moo");
		$.ajax({
			url : "uval",
			type : "GET",
			contentType : "application/json; charset=utf-8",
			data : {username},
			success : data1
			
		});}
}

function pwdValidation() {
	var pattern = /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,}$/;
	var password =$("#Spwd").val();
	console.log(password);
	if(password.match(pattern)){
		$("#pwdWarning").text("");
		return "true";
	}else{
		$("#pwdWarning").text("Password minimum length should be 6 characters & alphanumeric with atleast one special character.");
		$("#Spwd").val("");
		$("#Sconfirm_pwd").val("");
		$("#cpwdWarning").text("");
		return false;
	}
		
}

function cpwdValidation() {
	var pwd =$("#Spwd").val();
	var cpwd =$("#Sconfirm_pwd").val();
	if(pwd === cpwd){
		$("#cpwdWarning").text("");
		return "true";
	}
	else{
		$("#cpwdWarning").text("Password does not match the confirm password.");
		$("#Spwd").val("");
		$("#Sconfirm_pwd").val("");
		return false;
	}
}

function checkAllFeilds() {
console.log("ankita");
var v1=$("#Spwd").val();
var v2=$("#Semail").val();
var v3=$("#Sconfirm_pwd").val();
console.log(v1);
	if(v1 == ""||v2 == ""||v3 == ""){
		//alert("invalid form");
	}
	else{
		var password =$("#Spwd").val();
		var email =$("#Semail").val();
			$.ajax({
				url : "ureg",
				type : "GET",
				contentType : "application/json; charset=utf-8",
				data : {password,email},
				success : function(data){
					//alert(data);
				}
		});
	}
}

function validateEmail() {
	var username=$("#Uemail").val();
	moo(function(data){
		if (data === "new") {
			$("#UemailWarning").text("EmailId doesnot exist");
			return false;
			} 
		else {
				$("#UemailWarning").text("");
				return "true";
			}
		    
	});
	
	
	function moo(data1){
		$.ajax({
			url : "uval",
			type : "GET",
			contentType : "application/json; charset=utf-8",
			data : {username},
			success : data1
		});
	}

}
		
function validatePwd() {
	var email=$("#Uemail").val();
	var password=$("#Upassword").val();
	moo(function(data){
		if (data === "new") {
			$("#UpwdWarning").text("Incorrect Password");
			return false;
			} 
		else {
				$("#UpwdWarning").text("");
				return "true";
			}
		    
	});
	
	
	function moo(data1){
		$.ajax({
			url : "pval",
			type : "GET",
			contentType : "application/json; charset=utf-8",
			data : {email,password},
			success : data1
		});
	}
}	

function loginUser() {
	var email=$("#Uemail").val();
	var password=$("#Upassword").val();
	if(email == ""||password == ""){
		//alert("invalid form");
	}
	else{
	$.ajax({
		url : "login",
		type : "GET",
		contentType : "application/json; charset=utf-8",
		data : {email,password},
		success : function(data) {
			if(data == "success") {
				location.reload();
			}else {
				window.stop();
			}
			
		},
	});
	var c =$.cookie("userCookie");
	//alert(c);
	}
	
}
function signOut() {
	console.log("signout");
	logout();
	gapi.auth.signOut();
	var c =$.cookie("userCookie");
	if(c == undefined){
		console.log("cookie undefined");
	}
	else{
		$.removeCookie("userCookie");
		console.log("cookie removed");
		location.reload();
	}
	
}

