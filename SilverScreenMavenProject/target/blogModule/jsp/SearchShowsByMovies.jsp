<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link
	href="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/SearchShowsByMovie.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/modal.css" />" rel="stylesheet">
<script
	src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" />"></script>
<script
	src="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" />"></script>
<script
	src="<c:url value="https://use.fontawesome.com/4db7f356f3.js" />"></script>
<script type="text/javascript">
var priceOptions = [];
var timeOptions = [];
var monthNames = ["January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December"
                ];
$(document).ready(function() {
	localStorage.setItem('location', 'NCR');
	$('#today_col').css("background-color","#061532");
	var release_date = new Date(${jsons}.m_date).getDate() + " " +monthNames[new Date(${jsons}.m_date).getMonth()] + " "+new Date(${jsons}.m_date).getFullYear();
	var duration = new Date(${jsons}.m_duration).getHours() + "hrs "+new Date(${jsons}.m_duration).getMinutes()+"mins";
	$('#movie_title').html('<a href="movieDetails/'+${jsons}.m_id+'"><h2 style= "color : white;">' + ${jsons}.m_name + "</h2></a>");
	$('#certification').text(${jsons}.m_certification);
	$('#genre').text(${jsons}.m_genre);
	$('#release_date').html('<span class="glyphicon glyphicon-calendar" style="vertical-align: top; color: white; padding-right: 2%"></span>' + release_date);
	$("#duration").html('<span class="glyphicon glyphicon-time" style="vertical-align: top; color: white; padding-right: 2%"></span>'+ duration);

	var d = new Date();
	$("#today_date").text(d.getDate());
	$("#tom_date").text(d.getDate() + 1);
	$("#after_date").text(d.getDate() + 2);
	
	var castObj = ${jsons}.cast;
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
	
	$('#formBody').html('<form id=detailsForm>'+
			'<div class="form-group">'+
			'<input type="text" class="form-control" id="email"'+
				'placeholder="EMAIL ADDRESS">'+
		'</div>'+
		'<div class="form-group">'+
			'<input type="password" class="form-control" id="num"'+
				'placeholder="MOBILE NUMBER">'+
		'</div>'+
		'<button type="submit" class="btn btn-default" id=formSubmit>GET DETAILS</button>'+
		'</form>')
	
});

$(document).on("click",'#formBody #resetBtn', function(){
	$('#resendModal').fadeOut("slow",function(){
        $(this).modal('hide')
    }).fadeIn("slow",function(){
	$('#formBody').html('<form id=detailsForm>'+
	'<div class="form-group">'+
	'<input type="text" class="form-control" id="email"'+
		'placeholder="EMAIL ADDRESS">'+
'</div>'+
'<div class="form-group">'+
	'<input type="password" class="form-control" id="num"'+
		'placeholder="MOBILE NUMBER">'+
'</div>'+
'<button type="submit" class="btn btn-default" id=formSubmit>GET DETAILS</button>'+
'</form>')
$(this).modal('show')
    });
});



$(document).on("click", "#formBody #detailsForm #formSubmit", function() {
	$('#resendModal').fadeOut("slow",function(){
        $(this).modal('hide')
    }).fadeIn("slow",function(){
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
    			$('#formBody').html('<p>Booking id: ' + responseText.bd_id + '</p><p>Cinema Hall: '+responseText.movie_show.audi.cinema.c_name+
    					'</p><p> Audi : ' + responseText.movie_show.audi.a_number + '</p><p> Seats : '+responseText.seats_booked+ '</p><p> Date : '
    					+date+'</p><p> Time : '+time+ '</p><p> Price per ticket : '+responseText.movie_show.ms_price+ '</p>' +
    					'<button type="submit" class="btn btn-default" id = "resetBtn" style = "background-color : #cc0000;color:#000000;width :100%">RESET</button>');
    		}
    	});
$(this).modal('show')
    });
	
})


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
				hallRow.append($("<td>").html('<a href="selectSeats/'+movie_shows[j].ms_id+'">' + (new Date(movie_shows[j].ms_timestamp).getHours()<10?'0':'') +new Date(movie_shows[j].ms_timestamp).getHours() + ":" +(new Date(movie_shows[j].ms_timestamp).getMinutes()<10?'0':'')+new Date(movie_shows[j].ms_timestamp).getMinutes()+"</a>"));}
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
				hallRow.append($("<td>").html('<a href="selectSeats/'+movie_shows[j].ms_id+'">' + (new Date(movie_shows[j].ms_timestamp).getHours()<10?'0':'') +new Date(movie_shows[j].ms_timestamp).getHours() + ":" +(new Date(movie_shows[j].ms_timestamp).getMinutes()<10?'0':'')+new Date(movie_shows[j].ms_timestamp).getMinutes()+"</a>"));}
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
				hallRow.append($("<td>").html('<a href="selectSeats/'+currentCityMovieShowForDay[j].ms_id+'">' + (new Date(currentCityMovieShowForDay[j].ms_timestamp).getHours()<10?'0':'') +new Date(currentCityMovieShowForDay[j].ms_timestamp).getHours() + ":" +(new Date(currentCityMovieShowForDay[j].ms_timestamp).getMinutes()<10?'0':'')+new Date(currentCityMovieShowForDay[j].ms_timestamp).getMinutes('mm')+"</a>"));}
		}
		
		$('#showtable').append(hallRow);
	}
}
	
	
$(document).on("click", "#dates td", function(e) {
    var data = $(this).attr('id');
    if(data == 'tom_col') {
    	$("#showtable").empty();
		$('#tom_col').css("background-color","#061532");
		$('#today_col').css("background-color","#ffffff");
		$('#after_col').css("background-color","#ffffff");
		createTableForDay('tom');
    	
    }
    if(data == 'today_col') {
    	$("#showtable").empty();
		$('#tom_col').css("background-color","#ffffff");
		$('#today_col').css("background-color","#061532");
		$('#after_col').css("background-color","#ffffff");
		createTableForDay('today');
    	
    }
    if(data == 'after_col') {
    	$("#showtable").empty();
		$('#tom_col').css("background-color","#ffffff");
		$('#today_col').css("background-color","#ffffff");
		$('#after_col').css("background-color","#061532");
		createTableForDay('after');
    	
    }
    e.stopPropagation();
});	

function createTableForDay(day) {
	var movie_shows = ${jsons}.movie_shows;
	
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
	<div class="container-fluid">
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
					<li class="active"><a href="#">Home</a></li>
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">Movies <!-- <span class="caret"></span> --></a>
						<!-- <ul class="dropdown-menu">
							<li><a href="#">Page 1-1</a></li>
							<li><a href="#">Page 1-2</a></li>
							<li><a href="#">Page 1-3</a></li>
						</ul> --></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"> Login/Sign Up</a></li>
					<li><a id="location" data-toggle="modal"
						data-target="#myModal"></a></li>
				</ul>
			</div>
		</div>
		</nav>
	</div>
	<!-- end of top nav bar -->

	<!-- jumbotron -->
	<div class="container-fluid">
		<div class="jumbotron">

			<header class="row" style="margin-top: 3%"> <img
				alt="Silver Screen" id="logoimg"
				src="<c:url value="/resources/images/silverscreen-logo-white.png"/>"
				onmouseover="this.src='<c:url value="/resources/images/silverscreen-logo.png"/>'"
				onmouseout="this.src='<c:url value="/resources/images/silverscreen-logo-white.png"/>'"
				class="pull-left ">
			<form class="col-sm-9 col-sm-offset-3" role="search"
				name="searchForm" style="width: 60%;" class="hidden-sm hidden-xs">
				<div class="input-group" style="display: block;">
					<input type="search" class="form-control"
						placeholder="Find Movies or Cinemas you like." name="srch-term"
						id="searchBox">
					<div class="input-group-btn">
						<button class="btn btn-default" id="searchButton" type="submit">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
			</form>
			</header>
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
		<header style="background-color: white;">
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
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						id=closeButton>Close</button>
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


					<p id=contact>
						<span class="glyphicon glyphicon-user"></span>&nbsp;Contact Us
					</p>

				</div>
				<div class="col-sm-offset-1 col-md-offset-1 col-sm-1 col-md-1">
					<a href="#" class="forsocial"><span
						class=" fa fa-facebook-square"></span></a> <a href="#"
						class="forsocial"><span class="fa fa-twitter-square "></span></a>
					<a href="#" class="forsocial"><span
						class="fa fa-linkedin-square"></span></a>

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
</body>
</html>
