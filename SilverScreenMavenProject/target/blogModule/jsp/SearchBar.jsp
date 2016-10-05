<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href= "<c:url value='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'/>"></link>
<script
	src="<c:url value= 'https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js' />"></script>
<script
	src="<c:url value='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>

<link rel="stylesheet" href="<c:url value='/resources/css/SearchBar.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/SearchBar.js'/>"></script>


<link rel="icon" href="<c:url value='/resources/images/silverscreen-logo-white.png'/>">

<title>Search for Movies or Cinemas</title>

</head>


<body class="container-fluid">
	<nav class="navbar navbar-inverse  navbar-fixed-top">

		<ul class="nav navbar-nav">
			<li><a href="#"><span class="glyphicon glyphicon-home"></span></a></li>
			<li class="active"><a href="moviesPage">Movies</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right" style="margin-right:0.2%;">
			<li><a href="#">Login/SignIn</a></li>
			<li><a id="location" data-toggle="modal" data-target="#myModal"></a></li>
		</ul>

	</nav>
	<!-- end of top nav bar -->


	<!-- logo of the site -->
	
	<header class="row" style="margin-top: 3%;">
		<img style="" alt="Silver Screen" id="logoimg"
			src="<c:url value='/resources/images/silverscreen-logo-white.png'/>" class="pull-left">
			
		<form class="col-sm-9 col-sm-offset-2" role="search" name="searchForm" style="width:60%">
        	<div class="input-group" style="display: block;">
           		<input type="text" class="form-control" placeholder="Find Movies or Cinemas you like." 
           			name="searchBox" id="searchBox" autocomplete="off">
            	<div class="input-group-btn">
                	<button class="btn btn-default" id="searchButton" type="submit"><i class="glyphicon glyphicon-search"></i></button>
            	</div>
        	</div>
        </form>
	</header>
	<!-- logo sec finish -->

	<div class="clearfix"/><br><br>
	<main id='main-Search' class='col-sm-5 col-sm-offset-3'>
		<ul id='ul-SearchResults'  style="list-style:none;">
		</ul>
	</main>

	<div class="clearfix"></div>
	<br>
	<div class="col-sm-4 col-sm-offset-5">
		<button type='button' class="btn-default pull-left btn-main-filter active" id='btn-MovieSearch'><b>MOVIES</b></button>
		<button type='button' class="btn-default pull-left btn-main-filter" id='btn-CinemaSearch'><b>CINEMAS</b></button>
	</div>

	<div class="clearfix"></div>
	<main id="main-Movies">	
		<br><br>
		<div class="pull-right">
			<button type="button" class="btn-default btn-sub-filter" id="btn-lang-Hindi">Hindi</button>
			<button type="button" class="btn-default btn-sub-filter" id="btn-lang-English">English</button>
			<button type="button" class="btn-default btn-sub-filter" id="btn-lang-Punjabi">Punjabi</button>
			<button type='button' class="btn-default btn-sub-filter" id='btn-lang-Tamil'>Tamil</button>
			<button type="button" class="btn-default btn-sub-filter" id="btn-lang-Telugu">Telugu</button>
			<button type="button" class="btn-default btn-sub-filter" id="btn-lang-Bengali">Bengali</button>
			<button type="button" class="btn-default btn-sub-filter" id="btn-lang-Haryanvi">Haryanvi</button>			
		</div>
		<br><br>
		
		<table id='tabHindi' class="col-sm-3 tab-lang">
			<tr><th>HINDI</th></tr>
		</table>

		<table id='tabEnglish' class='col-sm-3 tab-lang'>
			<tr><th>ENGLISH</th></tr>
		</table>

		<div class="col-sm-3">
			<table id='tabPunjabi' class="tab-lang">
				<tr><th>PUNJABI</th></tr>
			</table>

			<table id='tabTamil' class="tab-lang">
				<tr><th>TAMIL</th></tr>
			</table>

			<table id='tabTelugu' class="tab-lang">
				<tr><th>TELUGU</th></tr>
			</table>

		</div>

			<table id='tabBengali' class="tab-lang">
				<tr><th>BENGALI</th></tr>
			</table>

			<table id='tabHaryanvi' class="tab-lang">
				<tr><th>HARYANVI</th></tr>
			</table>
		
	</main>

	<main id="main-Cinemas">
		<div class="clearfix"/><br><br>

		<table id='tabCinemas1' class="col-sm-3">
			<tr><th>CINEMAS</th></tr>
		</table>

		<table id='tabCinemas2' class="col-sm-3">
			<tr><th></th></tr>
		</table>


		<table id='tabCinemas3' class="col-sm-3">
			<tr><th></th></tr>
		</table>

	</main>
	
</body>
<script type="text/javascript">

$(function() {

	loadData();
	
	function loadData() {
		var jsonM = ${jsonM};
		var jsonC = ${jsonC};
	
		for(var i= 0; i<jsonM.length ; ++i) {
			var row = "<tr><td><a href='showList/" + jsonM[i].m_id + "'>" 
				+ jsonM[i].m_name + " (" + jsonM[i].m_certification + ") </a></tr></td>";
			$("#tab" + jsonM[i].m_language).append(row);
		}
		
		localStorage.setItem('location', 'NCR');
		var loc = localStorage.getItem('location');
		$('#location').text(loc);
		
		for(var i=0; i<jsonC.length; ++i) {
			if(loc == jsonC[i].c_location) {
				//alert(loc);
				var row = "<tr><td><a href='movieList/" + jsonC[i].c_id + "'>" 
				+ jsonC[i].c_name + " (" + jsonC[i].c_location + ") </a></tr></td>";
				$("#tabCinemas" + (i%3 + 1)).append(row);
			}
		}
	}

});
</script>
</html>


<!-- Search button not aligned
	css active/hover not working on buttons -->