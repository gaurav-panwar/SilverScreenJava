<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Movie shows</title>
<link
	href="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet">
<script src="<c:url value="https://apis.google.com/js/api:client.js" />"></script>
<script
	src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" />"></script>
<link href="<c:url value="/resources/css/SearchShowsByMovie.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/modal.css" />" rel="stylesheet">

<script
	src="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" />"></script>
<script
	src="<c:url value="https://use.fontawesome.com/4db7f356f3.js" />"></script>
	<script src="<c:url value="/resources/js/jquery.cookie.js" />"></script>
	<script src="<c:url value="/resources/js/login.js" />">
	
</script>
<link href="<c:url value="/resources/css/login.css" />">
<script type="text/javascript">
var priceOptions = [];
var timeOptions = [];
var data = "";
var monthNames = ["January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December"
                ];
$(document).ready(function() {
	
	$("#location").html($("#locate").val());

	$("#enter-button").click(function() {
		var loc = $("#locate option:selected").val();
		localStorage.setItem("location", loc);
		$("#location").html($("#locate").val());
		location.reload();

	});
	
	loadData();

	
	
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


function loadData() {
	
	$.ajax({
		url : '/SilverScreenMavenProject/getShowListAjax',
		data : {
			m_id : ${m_id}
		},
		success : function(responseText) {
			
			data = JSON.parse(responseText);
			////alert(data.toString());
			$('#today_col').css("background-color","#061532");
			var release_date = new Date(data.m_date).getDate() + " " +monthNames[new Date(data.m_date).getMonth()] + " "+new Date(data.m_date).getFullYear();
			var duration = new Date(data.m_duration).getHours() + "hrs "+new Date(data.m_duration).getMinutes()+"mins";
			$('#movie_title').html('<a href="/SilverScreenMavenProject/movieDetails/'+data.m_id+'"><h2 style= "color : white;">' + data.m_name + "</h2></a>");
			$('#certification').text(data.m_certification);
			$('#genre').text(data.m_genre);
			$('#release_date').html('<span class="glyphicon glyphicon-calendar" style="vertical-align: top; color: white; padding-right: 2%"></span>' + release_date);
			$("#duration").html('<span class="glyphicon glyphicon-time" style="vertical-align: top; color: white; padding-right: 2%"></span>'+ duration);

			var d = new Date();
			$("#today_date").text(d.getDate());
			$("#tom_date").text(d.getDate() + 1);
			$("#after_date").text(d.getDate() + 2);
			
			var castObj = data.cast;
			var actors = [];
			var directors = [];
			for(var i = 0; i<castObj.length; i++) {
				var arrayEle = castObj[i];
				if(arrayEle.cast_position == 'Actor') {
					actors.push(arrayEle.cast_name);
				}
				else {
					directors.push(arrayEle.cast_name);
				}
			}
			
			var actorRow = $("<tr>");
			actorRow.append( $("<td>").text("Actors:") );
			for(var i =0; i<actors.length; i++){
				actorRow.append($("<td>").html('<p><i class="fa fa-user" aria-hidden="true"></i>&nbsp; &nbsp;'+actors[i] +'</p>'))
			}
			
			var directorsRow = $("<tr>");
			directorsRow.append( $("<td>").text("Directors:") );
			for(var i =0; i<directors.length; i++){
				directorsRow.append($("<td>").html('<p><i class="fa fa-film" aria-hidden="true"></i>&nbsp; &nbsp;'+directors[i] +'</p>'))
			}
			
			$('#cast').append(actorRow);
			$('#cast').append(directorsRow);
			
			createTableForDay('today');
		}
	});
	
}



function getMovieShows(movie_shows, day) {
	var currentCityMovieShow = [];
	var d = new Date();
	var val = d;
	if(day == 'tom' ) {val = new Date(new Date().getTime() + 24 * 60 * 60 * 1000);}
	if(day == 'after' ) {val = new Date(new Date().getTime() + 24 * 60 * 60 * 1000*2);}
	
		for(var i = 0; i<movie_shows.length; i++) {
			if(movie_shows[i].audi.cinema.c_location == localStorage.getItem('location')){
				if(val.getDate() == new Date(movie_shows[i].ms_timestamp).getDate() && val.getMonth() == new Date(movie_shows[i].ms_timestamp).getMonth() && val.getFullYear() == new Date(movie_shows[i].ms_timestamp).getFullYear() ){
					currentCityMovieShow.push(movie_shows[i]);}
			}
		}
	
	
	return currentCityMovieShow;
	
}


function getHallArray(movie_shows) {
	var hallArray = [];
	for(var i = 0; i<movie_shows.length ; i++) {
		var flag = 0;
		for(var j = 0; j<hallArray.length ; j++) {
			if(hallArray[j] == movie_shows[i].audi.cinema.c_name){
				flag = 1;
			}
		}
		if(flag == 0){
			hallArray.push(movie_shows[i].audi.cinema.c_name);
		}
	}
	
	return hallArray;
}


function getMovieShowsByPrice(movie_shows, hallArray, arr) {
	$("#showtable").empty();
	for(var i = 0; i<hallArray.length ; i++) {
		var hallRow = $("<tr>").attr('id',hallArray[i]);
		hallRow.append($("<td>").html("<p><i class='fa fa-ticket' aria-hidden='true'></i>" + hallArray[i] + "</p>"));

		for(var j = 0; j<movie_shows.length ; j++) {
		if(arr.length != 0)	{
		for(var k =0; k<arr.length; k++){
			if(hallArray[i] == movie_shows[j].audi.cinema.c_name  && parseInt(movie_shows[j].ms_price) == parseInt(arr[k])) {
				hallRow.append($("<td>").html('<a href="/SilverScreenMavenProject/selectSeats/'+movie_shows[j].ms_id+'">' + (new Date(movie_shows[j].ms_timestamp).getHours()<10?'0':'') +new Date(movie_shows[j].ms_timestamp).getHours() + ":" +(new Date(movie_shows[j].ms_timestamp).getMinutes()<10?'0':'')+new Date(movie_shows[j].ms_timestamp).getMinutes()+"</a>"));}
		}
		}}
		
		$('#showtable').append(hallRow);
	}
	
	if(arr.length == 0){
		$("#showtable").empty();
		createTable(movie_shows, hallArray);
	}
	
}

function getMovieShowsByTime(movie_shows, hallArray, arr) {
	$("#showtable").empty();
	for(var i = 0; i<hallArray.length ; i++) {
		var hallRow = $("<tr>").attr('id',hallArray[i]);
		hallRow.append($("<td>").html("<p><i class='fa fa-ticket' aria-hidden='true'></i>" + hallArray[i] + "</p>"));

		for(var j = 0; j<movie_shows.length ; j++) {
		if(arr.length != 0)	{
		for(var k =0; k<arr.length; k++){
			var movie_time = new Date(movie_shows[j].ms_timestamp).getHours() + ":" +new Date(movie_shows[j].ms_timestamp).getMinutes();
			if(hallArray[i] == movie_shows[j].audi.cinema.c_name  && movie_time == arr[k]) {
				hallRow.append($("<td>").html('<a href="/SilverScreenMavenProject/selectSeats/'+movie_shows[j].ms_id+'">' + (new Date(movie_shows[j].ms_timestamp).getHours()<10?'0':'') +new Date(movie_shows[j].ms_timestamp).getHours() + ":" +(new Date(movie_shows[j].ms_timestamp).getMinutes()<10?'0':'')+new Date(movie_shows[j].ms_timestamp).getMinutes()+"</a>"));}
		}
		}}
		
		$('#showtable').append(hallRow);
	}
	
	if(arr.length == 0){
		$("#showtable").empty();
		createTable(movie_shows, hallArray);
	}
	
}

function createTable(currentCityMovieShowForDay, hallArray){
	
	for(var i = 0; i<hallArray.length ; i++) {
		var hallRow = $("<tr>").attr('id',hallArray[i]);
		hallRow.append($("<td>").html("<p><i class='fa fa-ticket' aria-hidden='true'></i>" + hallArray[i] + "</p>"));

		for(var j = 0; j<currentCityMovieShowForDay.length ; j++) {
			if(hallArray[i] == currentCityMovieShowForDay[j].audi.cinema.c_name ) {
				hallRow.append($("<td>").html('<a href="/SilverScreenMavenProject/selectSeats/'+currentCityMovieShowForDay[j].ms_id+'">' + (new Date(currentCityMovieShowForDay[j].ms_timestamp).getHours()<10?'0':'') +new Date(currentCityMovieShowForDay[j].ms_timestamp).getHours() + ":" +(new Date(currentCityMovieShowForDay[j].ms_timestamp).getMinutes()<10?'0':'')+new Date(currentCityMovieShowForDay[j].ms_timestamp).getMinutes('mm')+"</a>"));}
		}
		
		$('#showtable').append(hallRow);
	}
}
	
	
$(document).on("click", "#dates td", function(e) {
    var data1 = $(this).attr('id');
    if(data1 == 'tom_col') {
    	$("#showtable").empty();
		$('#tom_col').css("background-color","#061532");
		$('#today_col').css("background-color","#ffffff");
		$('#after_col').css("background-color","#ffffff");
		createTableForDay('tom');
    	
    }
    if(data1 == 'today_col') {
    	$("#showtable").empty();
		$('#tom_col').css("background-color","#ffffff");
		$('#today_col').css("background-color","#061532");
		$('#after_col').css("background-color","#ffffff");
		createTableForDay('today');
    	
    }
    if(data1 == 'after_col') {
    	$("#showtable").empty();
		$('#tom_col').css("background-color","#ffffff");
		$('#today_col').css("background-color","#ffffff");
		$('#after_col').css("background-color","#061532");
		createTableForDay('after');
    	
    }
    e.stopPropagation();
});	

function createTableForDay(day) {
	var movie_shows = data.movie_shows;
	
	var currentCityMovieShowForDay = getMovieShows(movie_shows, day);
	var hallArray = getHallArray(currentCityMovieShowForDay);
	currentCityMovieShowForDay.sort(function(a, b) {
		return a.ms_timestamp - b.ms_timestamp;
	})
	
	createTable(currentCityMovieShowForDay, hallArray);
	uncheck();
	
	priceOptions = getfilters('priceFilter', currentCityMovieShowForDay,hallArray );
	timeOptions = getfilters('timeFilter', currentCityMovieShowForDay,hallArray );
}

function getfilters(id, currentCityMovieShowForDay,hallArray) {
	
	var arr = [];
	$('#'+id+'>li>a').on( 'click', function(event) {
	    var target = $(event.target),
	       val = target.attr( 'value' ),
	       inp = $(target).find( 'input' ),
	       idx;

	   if ( ( idx = arr.indexOf( val ) ) > -1 ) {
		   arr.splice( idx, 1 );
	      setTimeout( function() { inp.prop( 'checked', false ) }, 0);
	   } else {
		   arr.push( val );
	      setTimeout( function() { inp.prop( 'checked', true ) }, 0);
	   }

	   $( event.target ).blur();
	   console.log(arr);
	   if(id == 'priceFilter') {
		   getMovieShowsByPrice(currentCityMovieShowForDay,hallArray, arr);
	   }
	   else {
		   getMovieShowsByTime(currentCityMovieShowForDay,hallArray, arr);
	   }
	  
	  return arr;
	});
	
	
}	
 function uncheck() {
	 jQuery('.priceCheck').attr('checked', false)
	 jQuery('.timeCheck').attr('checked', false)
	priceOptions = [];
	timeOptions = [];
} 

</script>
</head>
<body>
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
					<li><a href="/SilverScreenMavenProject/moviesPage">Movies</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li id="log"></li>

					<li><a id="location" data-toggle="modal" href="#myModal"
						data-target="#myModal" style="padding-right: 20px"></a></li>
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
	<!-- end of top nav bar -->

	<!-- jumbotron -->
	<div class="container-fluid">
		<div class="jumbotron">
			<div id=movie_title></div>
			<div class="table-responsive">
				<table class="table" style="width: 60%">
					<tr>
						<td><p id=certification></p></td>
						<td><p id=genre></p></td>
						<td><p id=release_date style="color: white;"></p></td>
						<td><p id=duration style="color: white;"></p></td>
					</tr>
				</table>
			</div>
			<div class="table-responsive">
				<table class="table" style="width: 100%" id=cast>
				</table>
			</div>
		</div>
	</div>
	<div class=container-fluid>
		<header style="background-color: white; margin-top: 0;">
		<div class=row>
			<div class=col-sm-4>
				<table width="300" id=dates>
					<tr>
						<td width="100" id=today_col><p class=date_val id=today_date></p>
							<p class=day id=today_day>TODAY</p></td>
						<td width="100" id=tom_col><p class=date_val id=tom_date></p>
							<p class=day id=tom_day>TOM</p></td>
						<td width="100" id=after_col><p class=date_val id=after_date></p>
							<p class=day id=after_day>AFTER</p></td>
					</tr>
				</table>
			</div>
			<div class=col-sm-2></div>
			<div class=col-sm-3>
				<div class="button-group">
					<button type="button"
						class="btn btn-default btn-sm dropdown-toggle"
						data-toggle="dropdown"
						style="font-size: large; border: none; float: right;">
						Filter Price Range</span> <span class="caret">
					</button>
					<ul class="dropdown-menu" id="priceFilter">
						<li><a href="#" class="small" value="200" tabIndex="-1"><input
								class="priceCheck" type="checkbox" />&nbsp;Rs 0 - Rs 200</a></li>
						<li><a href="#" class="small" value="300" tabIndex="-1"><input
								class="priceCheck" type="checkbox" />&nbsp;Rs 201 - Rs 300</a></li>
					</ul>
				</div>
			</div>
			<div class=col-sm-3>
				<div class="button-group">
					<button type="button"
						class="btn btn-default btn-sm dropdown-toggle"
						data-toggle="dropdown"
						style="font-size: large; border: none; float: right;">
						Filter Show Timings</span> <span class="caret">
					</button>
					<ul class="dropdown-menu" id=timeFilter>
						<li><a href="#" class="small" value="9:0" tabIndex="-1"><input
								class="timeCheck" type="checkbox" />&nbsp;9:00 AM</a></li>
						<li><a href="#" class="small" value="12:0" tabIndex="-1"><input
								class="timeCheck" type="checkbox" />&nbsp;12:00 PM</a></li>
						<li><a href="#" class="small" value="15:0" tabIndex="-1"><input
								class="timeCheck" type="checkbox" />&nbsp;3:00 PM</a></li>
						<li><a href="#" class="small" value="18:0" tabIndex="-1"><input
								class="timeCheck" type="checkbox" />&nbsp;6:00 PM</a></li>
						<li><a href="#" class="small" value="21:0" tabIndex="-1"><input
								class="timeCheck" type="checkbox" />&nbsp;9:00 PM</a></li>
					</ul>
				</div>
			</div>
		</div>

		</header>

	</div>

	<div id=shows class=container-fluid
		style="padding: 2px; background-color: #f1f1f1; min-height:">
		<div class="table-responsive">
			<table class="table"
				style="background-color: white; font-size: large; margin-bottom: 0px;"
				id=showtable>
			</table>
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
								<input type="password" class="form-control" id="num"
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
	<!-- Footer -->
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
</body>
</html>
