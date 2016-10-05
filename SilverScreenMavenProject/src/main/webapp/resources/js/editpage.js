/*$(document).ready(function() {
					$("#verifydiv").hide();
					$("#update").hide();});

 */
$(document).ready(function(){
	$("#verifydiv").hide();
	$("#update").hide();
	var normalData;
	abc();
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
	    			var date = new Date(responseText.movie_show.ms_timestamp).getDate() +"/"+ (new Date(responseText.movie_show.ms_timestamp).getMonth()+1 )+"/"+ new Date(responseText.movie_show.ms_timestamp).getFullYear();
	    			var time = new Date(responseText.movie_show.ms_timestamp).getHours() +":"+ new Date(responseText.movie_show.ms_timestamp).getMinutes();
	    			$("#b_id").text("Booking id :" + responseText.bd_id);
					$("#cinema_name").text("Hall : " + responseText.movie_show.audi.cinema.c_name);
					$("#audi_num").text("Audi number : "+responseText.movie_show.audi.a_number);
					$("#seats_booked").text("Seats booked : " + responseText.seats_booked);
					$("#dateOfShow").text("Date of show : "+date);
					$("#timeOfShow").text("time of show :"+time);
					$("#pricePerShow").text(responseText.movie_show.ms_price);
					
					document.getElementById('resultData').style.display = "block";
					document.getElementById('detailsForm').style.display = "none";
	    		}
	    	});
	})
	
});

function check() {
	var id1 = $("#name").val();
	//alert(id1);
	var id3 = $("#datepicker").val();
	//alert(id3);
	var id4 = $("#number").val();
	//alert(id4);

	if (id1 == "" || id4 == "") {

		$("#update").hide();						
		$("#message2").text("**fill all fields");
		$("#message2").css({"color":"red","margin-top":" 2%"});
	} else {

		/*var pattern = /^\d{10}$/;
		 var y=pattern.test(id4);
		 console.log(y);
		 var patt=/^[a-zA-Z] [a-zA-Z]{3,20}$/;
		 var z=patt.test(id1);
		 console.log(z);

		if( y == false|| z == false){

			$("#message2").text("**fill all fields correctly");
			$("#message2").css({"color":"red","margin-top":" 2%"});
		}*/

		$("#update").show();
	}}

function subForm(){
	var name = $("#name").val();
	//alert(name+" hello");
	var dob = $("#datepicker").val();
	//alert("dob " + typeof dob);

	var number = $("#number").val();
	//alert(number+" hello");
	$.ajax({
		url: "/SilverScreenMavenProject/edit",
		type:"GET",
		data: {dob,name,number},
		success: function(data) {
			$("#updateComplete").text("Update complete");
		}
	});
}
function abc() {
	$.get("/SilverScreenMavenProject/getU",function(data,status){
		normalData = JSON.parse(data);
		$("#name").val(normalData["name"]);
		//alert(normalData["name"]);
		$("#editemail").val(normalData["email"]);
		//alert(normalData["email"]);
		$("#number").val(normalData["number"]);
		if(normalData["gender"] == "F")
			$("#f").attr("checked","checked");
		else{

			$("#m").attr("checked","checked");
		}
	});
}

function passBlur() {
	$("#con").text();
	$("#verifydiv").hide();
	var id1 = $("#newpassword").val();
	console.log(id1);
	var id2 = $("#confirmnewpassword")
	.val();
	console.log(id2);
	var id3 = $("#curpassword").val();
	console.log(id3);
	if (id1 == "" || id2 == "" || id3 == "") {

		$("#verifydiv").hide();


		$("#message").text("**fill all fields");
		$("#message").css({"color":"red","padding-top":" 2%"});

	} else {

		if (id1 == id2) {
			valPwd();


		} else {

			$("#verifydiv").hide();
			$("#con").text("newpassword and confirm password are not matching");

			$("#con").css({"color":"red"});

		}
	}

}





function verifyFun(){
	//alert("click verify button");
	var currpassword=$("#curpassword").val();
	var newpassword=$("#newpassword").val();
	$.ajax({
		url:"/SilverScreenMavenProject/chngpasswrd",
		type:"POST",
		data:{currpassword,newpassword},
		complete:function(data,status){
			alert("Password changed");
		}

	});

}

function valPwd() {
	var currpassword=$("#curpassword").val();
	//alert(currpassword);
	console.log("hello");
	$.ajax({
		url : "/SilverScreenMavenProject/getEmail",
		type : "GET",
		contentType : "application/json; charset=utf-8",
		data : {currpassword},
		success : function(data) {
			if(data == "exist"){
				$("#verifydiv").show();
				$("#curWarn").text("");
			}
			else{
				$("#curWarn").text("Current password didn't match");
				//alert(data);
				$("#verifydiv").hide();

			}
		}

	});
}	
