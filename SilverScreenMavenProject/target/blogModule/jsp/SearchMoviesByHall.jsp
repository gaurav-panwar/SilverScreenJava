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
<script
	src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" />"></script>
<script
	src="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" />"></script>
<script
	src="<c:url value="https://use.fontawesome.com/4db7f356f3.js" />"></script>
<script type="text/javascript">
var priceOptions = [];
var timeOptions = [];
$(document).ready(function() {
	$('#today_col').css("background-color","#061532");
	$("#hall_title").text(${jsons}.c_name);
	var d = new Date();
	$("#today_date").text(d.getDate());
	$("#tom_date").text(d.getDate() + 1);
	$("#after_date").text(d.getDate() + 2);
	
	createTableForDay('today');
	
});

function getMovieShows(audis) {
	var movieShowList = [];
	for(var i =0; i<audis.length; i++){
		
		var movie_shows = audis[i].movie_shows;
		for(var j = 0; j<movie_shows.length; j++){
			movieShowList.push(movie_shows[j]);
		}
	}
	
	return movieShowList
	
}

function getMovieShowByDay(movie_shows, day) {
	var movieShowsByDay = [];
	var d = new Date();
	var val = d;
	if(day == 'tom' ) {
		val = new Date(new Date().getTime() + 24 * 60 * 60 * 1000);
		}
	if(day == 'after' ) {
		val = new Date(new Date().getTime() + 24 * 60 * 60 * 1000 * 2);
		}
		for(var i = 0; i<movie_shows.length; i++) {
			if(val.getDate() == new Date(movie_shows[i].ms_timestamp).getDate() && val.getMonth() == new Date(movie_shows[i].ms_timestamp).getMonth() && val.getFullYear() == new Date(movie_shows[i].ms_timestamp).getFullYear() )
			{
				movieShowsByDay.push(movie_shows[i]);
				}
		}
	
	return movieShowsByDay;
	
}

function getMovies(movieShowByDay) {
	var movieArray = [];
	for(var i = 0; i<movieShowByDay.length ; i++) {
		var flag = 0;
		for(var j = 0; j<movieArray.length ; j++) {
			if(movieArray[j] == movieShowByDay[i].movie.m_name){
				flag = 1;
			}
		}
		if(flag == 0){
			movieArray.push(movieShowByDay[i].movie.m_name);
		}
	}
	
	return movieArray;	
}

function getMovieShowsByPrice(movie_shows, movieArray, arr) {
	$("#movieTable").empty();
	for(var i = 0; i<movieArray.length ; i++) {
		var movieRow = $("<tr>").attr('id',movieArray[i]);
		movieRow.append($("<td>").html("<p><i class='fa fa-ticket' aria-hidden='true'></i>" + movieArray[i] + "</p>"));

		for(var j = 0; j<movie_shows.length ; j++) {
		if(arr.length != 0)	{
		for(var k =0; k<arr.length; k++){
			if(movieArray[i] == movie_shows[j].movie.m_name  && parseInt(movie_shows[j].ms_price) == parseInt(arr[k])) {
				movieRow.append($("<td>").html('<a href="selectSeats/'+movie_shows[j].ms_id+'">' + (new Date(movie_shows[j].ms_timestamp).getHours()<10?'0':'') +new Date(movie_shows[j].ms_timestamp).getHours() + ":" +(new Date(movie_shows[j].ms_timestamp).getMinutes()<10?'0':'')+new Date(movie_shows[j].ms_timestamp).getMinutes()+"</a>"));}
		}
		}}
		
		$('#movieTable').append(movieRow);
	}
	
	if(arr.length == 0){
		$("#movieTable").empty();
		createTable(movie_shows, movieArray);
	}
	
}

function getMovieShowsByTime(movie_shows, movieArray, arr) {
	$("#movieTable").empty();
	for(var i = 0; i<movieArray.length ; i++) {
		var movieRow = $("<tr>").attr('id',movieArray[i]);
		movieRow.append($("<td>").html("<p><i class='fa fa-ticket' aria-hidden='true'></i>" + movieArray[i] + "</p>"));

		for(var j = 0; j<movie_shows.length ; j++) {
		if(arr.length != 0)	{
		for(var k =0; k<arr.length; k++){
			var movie_time = new Date(movie_shows[j].ms_timestamp).getHours() + ":" +new Date(movie_shows[j].ms_timestamp).getMinutes();
			if(movieArray[i] == movie_shows[j].movie.m_name  && movie_time == arr[k]) {
				movieRow.append($("<td>").html('<a href="selectSeats/'+movie_shows[j].ms_id+'">' + (new Date(movie_shows[j].ms_timestamp).getHours()<10?'0':'') +new Date(movie_shows[j].ms_timestamp).getHours() + ":" +(new Date(movie_shows[j].ms_timestamp).getMinutes()<10?'0':'')+new Date(movie_shows[j].ms_timestamp).getMinutes()+"</a>"));}
		}
		}}
		
		$('#movieTable').append(movieRow);
	}
	
	if(arr.length == 0){
		$("#movieTable").empty();
		createTable(movie_shows, movieArray);
	}
	
}

function createTable(movieShowForDay, movieArray){
	
	for(var i = 0; i<movieArray.length ; i++) {
		var movieRow = $("<tr>").attr('id',movieArray[i]);
		movieRow.append($("<td>").html("<p><i class='fa fa-ticket' aria-hidden='true'></i>" + movieArray[i] + "</p>"));

		for(var j = 0; j<movieShowForDay.length ; j++) {
			if(movieArray[i] == movieShowForDay[j].movie.m_name ) {
				movieRow.append($("<td>").html('<a href="selectSeats/'+movieShowForDay[j].ms_id+'">' + (new Date(movieShowForDay[j].ms_timestamp).getHours()<10?'0':'') +new Date(movieShowForDay[j].ms_timestamp).getHours() + ":" +(new Date(movieShowForDay[j].ms_timestamp).getMinutes()<10?'0':'')+new Date(movieShowForDay[j].ms_timestamp).getMinutes()+"</a>"));}
		}
		
		$('#movieTable').append(movieRow);
	}
	
}
	
	
$(document).on("click", "#dates td", function(e) {
    var data = $(this).attr('id');
    if(data == 'tom_col') {
    	$("#movieTable").empty();
		$('#tom_col').css("background-color","#061532");
		$('#today_col').css("background-color","#ffffff");
		$('#after_col').css("background-color","#ffffff");
		createTableForDay('tom');
    	
    }
    if(data == 'today_col') {
    	$("#movieTable").empty();
		$('#tom_col').css("background-color","#ffffff");
		$('#today_col').css("background-color","#061532");
		$('#after_col').css("background-color","#ffffff");
		createTableForDay('today');
    	
    }
    if(data == 'after_col') {
    	$("#movieTable").empty();
		$('#tom_col').css("background-color","#ffffff");
		$('#today_col').css("background-color","#ffffff");
		$('#after_col').css("background-color","#061532");
		createTableForDay('after');
    	
    }
    e.stopPropagation();
});	

function createTableForDay(day) {
	var audis = ${jsons}.audis;
	
	 var movieShowList = getMovieShows(audis);
	var movieShowByDay = getMovieShowByDay(movieShowList, day);
	var moviesArray = getMovies(movieShowByDay);
	movieShowByDay.sort(function(a, b) {
		return a.ms_timestamp - b.ms_timestamp;
	})
	uncheck();
	createTable(movieShowByDay, moviesArray);
	
	priceOptions = getfilters('priceFilter', movieShowByDay,moviesArray );
	timeOptions = getfilters('timeFilter', movieShowByDay,moviesArray ); 	
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
		<!-- nav bar with links -->
		<nav class="navbar navbar-inverse  navbar-fixed-top">

		<ul class="nav navbar-nav">
			<li><a href="#"><span class="glyphicon glyphicon-home"></span></a></li>
			<li class="active"><a href="#">Movies</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#">Login/SignIn</a></li>
			<li><a id="location" data-toggle="modal" data-target="#myModal"></a></li>
		</ul>

		</nav>
	</div>
	<!-- end of top nav bar -->

	<!-- jumbotron -->
	<div class="container-fluid">
		<div class="jumbotron">

			<header class="row" style="margin-top: 3%"> <img
				alt="Silver Screen" id="logoimg"
				src="<c:url value="/resources/images/silverscreen-logo-white.png"/>"
				class="pull-left ">
			<form class="col-sm-9 col-sm-offset-3" role="search"
				name="searchForm" style="width: 60%;">
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
			<h2 style="color: white;" id=hall_title></h2>
			<br>
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
						<li><a href="#" class="small" value="200" tabIndex="-1"><input class="priceCheck"
								type="checkbox" />&nbsp;Rs 0 - Rs 200</a></li>
						<li><a href="#" class="small" value="300" tabIndex="-1"><input class="priceCheck"
								type="checkbox" />&nbsp;Rs 201 - Rs 300</a></li>
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
						<li><a href="#" class="small" value="9:0" tabIndex="-1"><input class="timeCheck"
								type="checkbox" />&nbsp;9:00 AM</a></li>
						<li><a href="#" class="small" value="12:0" tabIndex="-1"><input class="timeCheck"
								type="checkbox" />&nbsp;12:00 PM</a></li>
						<li><a href="#" class="small" value="15:0" tabIndex="-1"><input class="timeCheck"
								type="checkbox" />&nbsp;3:00 PM</a></li>
						<li><a href="#" class="small" value="18:0" tabIndex="-1"><input class="timeCheck"
								type="checkbox" />&nbsp;6:00 PM</a></li>
						<li><a href="#" class="small" value="21:0" tabIndex="-1"><input class="timeCheck"
								type="checkbox" />&nbsp;9:00 PM</a></li>
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
				id=movieTable>
			</table>
		</div>
	</div>
	<!-- Footer -->
	<div class=container-fluid>
		<footer>
		<div class="lasttab">
			<div class="row">
				<div class="col-sm-offset-1 col-sm-3 col-md-offset-1 col-md-3">

					<span class="glyphicon glyphicon-user"></span> <a href="#"
						class="forlink">Contact Us</a>

				</div>
				<div class="col-sm-offset-1 col-md-offset-1 col-sm-1 col-md-1">
					<a href="#" class="forsocial"><span
						class=" fa fa-facebook-square"></span></a> <a href="#"
						class="forsocial"><span class="fa fa-twitter-square "></span></a>
					<a href="#" class="forsocial"><span
						class="fa fa-linkedin-square"></span></a>

				</div>


				<div class="col-sm-offset-3 col-md-offset-3 col-sm-3 col-md-3">
					<span class="glyphicon glyphicon-phone"></span> <a href="#"
						class="forlink">Resend Confirmation</a>
				</div>
			</div>
		</div>

		</footer>
	</div>
</body>
</html>
