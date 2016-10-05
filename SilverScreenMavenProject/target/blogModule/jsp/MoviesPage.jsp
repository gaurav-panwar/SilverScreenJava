<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<title>Movies Page</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="<c:url value='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css' />"></script>
<script src="<c:url value= 'https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js' />"></script>
<script src="<c:url value='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>
<script src="<c:url value='https://use.fontawesome.com/4cac0da64a.js' />"></script>

<link rel="icon" href="<c:url value='/resources/images/silverscreen-logo-white.png' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/MoviesPage.css' />">
<script type="text/javascript" src="<c:url value='/resources/js/MoviesPage.js' />"></script>

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
	<!-- end of top nav bar -->


	<!-- logo of the site -->
	
	<header class="row" style="margin-top: 3%;">
		<img style="" alt="Silver Screen" id="logoimg"
			src="<c:url value='/resources/images/silverscreen-logo-white.png' />" class="pull-left">
			
		<form class="col-sm-9 col-sm-offset-2 col-xs-9 col-xs-offset-2" role="search" name = "searchForm" style="width:60%">
        	<div class="input-group" style="display: block;">
           		<input type="search" class="form-control" placeholder="Find Movies or Cinemas you like." name="srch-term" id="searchBox">
            	<div class="input-group-btn">
                	<button class="btn btn-default" id="searchButton" type="submit"><i class="glyphicon glyphicon-search"></i></button>
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


	<main>
		<br><br>
		<p class="col-sm-1 col-sm-offset-5" id='movieText'><b>MOVIES</b></p>
		<div class="clearfix"></div>
		<br><br>

	<div class="col-sm-4 col-sm-offset-4">
		<button type='button' class="btn-default pull-left btn-ns-filter active" id='btn-NowShowing'><b>NOW SHOWING</b></button>
		<button type='button' class="btn-default pull-left btn-ns-filter" id='btn-ComingSoon'><b>COMING SOON</b></button>
	</div>
	<div class="clearfix"></div>
	<br><br>
	<hr>

	</main>

	<!-- Filters -->
	<main id='main-filters'>
		<div class="col-filters col-sm-2 pull-left" style="background-color: white;">
			<table>
				<tr><th style="font-size: 20px;">Filter By</th></tr>
			</table>
			<hr>

			<table id='tab-Lang-Filter' class='tab-filters'>
				<tr><th style="text-align:center;">LANGUAGE</th></tr>
				<tr><td><input type="checkbox" name="lang-filter" value="Hindi" id='Hindi-filter'>
						<label for="Hindi-filter">&nbsp; Hindi</label></td></tr>
				<tr><td><input type="checkbox" name="lang-filter" value="English" id='English-filter'>
						<label for="English-filter">&nbsp; English</label></td></tr>
				<tr><td><input type="checkbox" name="lang-filter" value="Punjabi" id='Punjabi-filter'>
						<label for="Punjabi-filter">&nbsp; Punjabi</label></td></tr>
				<tr><td><input type="checkbox" name="lang-filter" value="Tamil" id='Tamil-filter'>
						<label for="Tamil-filter">&nbsp; Tamil</label></td></tr>
				<tr><td><input type="checkbox" name="lang-filter" value="Telugu" id='Telugu-filter'>
						<label for="Telugu-filter">&nbsp; Telugu</label></td></tr>
				<tr><td><input type="checkbox" name="lang-filter" value="Bengali" id='Bengali-filter'>
						<label for="Bengali-filter">&nbsp; Bengali</label></td></tr>
				<tr><td><input type="checkbox" name="lang-filter" value='Haryanvi' id='Haryanvi-filter'>
						<label for="Haryanvi-filter">&nbsp; Haryanvi</label></td></tr>
			</table>

			<br>
			<table id='tab-Genre-Filter' class='tab-filters'>
				<tr><th style="text-align:center;">GENRE</th></tr>
				<tr><td><input type="checkbox" name="genre-filter" value="Action" id='Action-filter'>
						<label for="Action-filter">&nbsp; Action</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value="Adventure" id='Adventure-filter'>
						<label for="Adventure-filter">&nbsp; Adventure</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value="Animation" id='Animation-filter'>
						<label for="Animation-filter">&nbsp; Animation</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value="Comedy" id='Comedy-filter'>
						<label for="Comedy-filter">&nbsp; Comedy</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value="Crime" id='Crime-filter'>
						<label for="Crime-filter">&nbsp; Crime</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value="Drama" id='Drama-filter'>
						<label for="Drama-filter">&nbsp; Drama</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value="Fantasy" id='Fantasy-filter'>
						<label for="Fantasy-filter">&nbsp; Fantasy</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value="Family" id='Family-filter'>
						<label for="Family-filter">&nbsp; Family</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value='Horror' id='Horror-filter'>
						<label for="Horror-filter">&nbsp; Horror</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value="Romance" id='Romance-filter'>
						<label for="Romance-filter">&nbsp; Romance</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value="Sci-fi" id='Sci-Fi-filter'>
						<label for="Sci-Fi-filter">&nbsp; Sci-Fi</label></td></tr>
				<tr><td><input type="checkbox" name="genre-filter" value='Thriller' id='Thriller-filter'>
						<label for="Thriller-filter">&nbsp; Thriller</label></td></tr>
			</table>

			<br>
			<table id='tab-Format-Filter' class='tab-filters'>
				<tr><th style="text-align:center;">FORMAT</th></tr>
				<tr><td><input type="checkbox" name="format-filter" value="2D" id='2D-filter'>
						<label for="2D-filter">&nbsp; 2D</label></td></tr>
				<tr><td><input type="checkbox" name="format-filter" value="3D" id='3D-filter'>
						<label for="3D-filter">&nbsp; 3D</label></td></tr>
				<tr><td><input type="checkbox" name="format-filter" value="4DX" id='4DX-filter'>
						<label for="4DX-filter">&nbsp; 4DX</label></td></tr>
				<tr><td><input type="checkbox" name="format-filter" value="IMAX" id='IMAX-filter'>
						<label for="IMAX-filter">&nbsp; IMAX</label></td></tr>
				<tr><td><input type="checkbox" name="format-filter" value="IMAX-3D" id='IMAX-3D-filter'>
						<label for="IMAX-3D-filter">&nbsp; IMAX-3D</label></td></tr>
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
		<br><br>
		<hr>
		<div class="top-movies col-sm-3" style="background-color: white;">
			<span class='col-sm-offset-2' style="border-bottom: 2px solid #cc0000; font-size: 20px;"><b>TOP MOVIES</b></span>
			<div class="clearfix"></div>

			<br>
			<ul id='topMovies' style="list-style:none;">
			</ul>
		</div>
	</main>

	<main id='main-NextChange' class='col-sm-offset-3'>
		<span class="col-sm-offset-3" style="border-bottom: 2px solid #cc0000; font-size: 20px;"><b>NEXT CHANGE</b></span>
		<br>
	</main>
	<div class="clearfix"></div>
		<br><br>

	
	<!-- Footer -->
	<footer>
		<div class="container-fluid">
		
			<div class="row">
				<div class="col-sm-offset-1 col-sm-3 col-md-offset-1 col-md-3">
					<span class="glyphicon glyphicon-user"></span>		
					<a href="#" class="forlink">Contact Us</a>	
				</div>
				
				<div class="col-sm-offset-1 col-sm-1">
						<a href="#" class="forsocial"><span class=" fa fa-facebook-square"></span></a>
					<a href="#" class="forsocial"><span class="fa fa-twitter-square "></span></a>
					<a href="#"  class="forsocial"><span class="fa fa-linkedin-square"></span></a>
					
				</div>
				
				<div class="col-sm-offset-3 col-md-offset-3 col-sm-3 col-md-3">
							<span class="glyphicon glyphicon-phone"></span>
							<a href="#" class="forlink">Resend Confirmation</a>
					</div>
				</div>
			</div>
	</footer>


<script type="text/javascript">
$(function() {
	
	loadData();
	
	function loadData() {
		var jsonNS = ${jsonNS};
		var jsonCS = ${jsonCS};
		console.log("jsonNS : " + jsonNS);
		console.log("jsonCS : " + jsonCS);
		var cnt = 0, cnc = 0;
		var mov_card = "";
		var row = "";
		var cr_item = "";
		
		for(var i=0; i<jsonNS.length; ++i) {
			cnt++;
			mov_card = createMovieCard(jsonNS[i], cnt);
			$('#main-NowShowing').append(mov_card);
			if(cnt%2 == 0) {
				row = createRow(jsonNS[i]);
				$('#topMovies').append(row);
			}
		}
		
		for(var i=0; i<jsonCS.length; ++i) {
			cnt++;
			mov_card = createMovieCard_CS(jsonCS[i], cnt);
			$('#main-ComingSoon').append(mov_card);
			if(cnc <3 /* && cnt%3 == 0 */) {
				cnc++;
				$('#main-NextChange').append(mov_card);
			}
			
			cr_item = createCarouselItem(jsonCS[i], cnc);
			console.log(cr_item);
			$('#carousel-list').append(cr_item);
		}
	}
	
	
	
	
	
	function createMovieCard(data, cnt) {
		var mov_card = "<div class='movie-tile col-sm-3 mv-lang-" + data.m_language + " mv-gen-" + data.m_genre + " mv-form-"+ data.m_format + "' id='mv-tl-" + cnt +"'>" 
			+ "<img src='<c:url value='" + data.m_poster + "' />' alt=" + data.m_name + "class='mv-icon' style='height:375px; width:260px;'>"
			+ "<br><div class='hover-btn'>"
			+ "<a class='trailer-link' href='" + data.m_trailer +"'>"
			+ "<span class='glyphicon glyphicon-play-circle btn-play'></span></a>"
			+ "<a class='btn-info' href='" + "showList/movieDetails/" + data.m_id + "'>"
			+ "<span class='glyphicon glyphicon-info-sign'></span></a>"
			+ "</div>"
			+ "<span id='mov-name'><b>" + data.m_name + " (" + data.m_certification + ") " + "</b></span><br>"
			+ "<span id='mov-lang'>" + data.m_language + " (" + data.m_format + ") " + "</span><br>"
			+ "<span id='mov-genre'>" + data.m_genre + "</span><br>"
			+ "<a href='" + "showList/" + data.m_id + "'> <button class='btn-book' type='button'>BOOK NOW</button></a>"
			+ "</div>";
			
		return mov_card;
	}
	
	function createMovieCard_CS(data, cnt) {
		var mov_card = "<div class='movie-tile col-sm-3 mv-lang-" + data.m_language + " mv-gen-" + data.m_genre + " mv-form-"+ data.m_format + "' id='mv-tl-" + cnt +"'>" 
		+ "<img src='<c:url value='" + data.m_poster + "' />' alt=" + data.m_name + "class='mv-icon' style='height:375px; width:260px;'>"
		+ "<br><div class='hover-btn'>"
		+ "<a class='trailer-link' href='" + data.m_trailer +"'>"
		+ "<span class='glyphicon glyphicon-play-circle btn-play'></span></a>"
		+ "<a class='btn-info' href='" + "showList/movieDetails/" + data.m_id + "'>"
		+ "<span class='glyphicon glyphicon-info-sign'></span></a>"
		+ "</div>"
		+ "<span id='mov-name'><b>" + data.m_name + " (" + data.m_certification + ") " + "</b></span><br>"
		+ "<span id='mov-lang'>" + data.m_language + " (" + data.m_format + ") " + "</span><br>"
		+ "<span id='mov-genre'>" + data.m_genre + "</span><br>";
		
		return mov_card;
	}
	
	function createRow(data) {
		var row = "<li><i class='fa fa-film'></i>"
				+ "<a href='" + "showList/movieDetails/" + data.m_id + "'>"
				+ "&nbsp;" + data.m_name +  "</a></li>";
		return row;
	}
	
	
	function createCarouselItem(data, cnt) {		
		var it = "<div align='center' class='item ";
		if(cnt == 1)
			it += "active";
		
		it += "'>"
			+ "<a href='" + "showList/movieDetails/" + data.m_id + "'>" 
			+ "<img src='<c:url value='" + data.m_poster + "' />'" 
			+ " alt='" + data.m_name + "' class='Carousel-Image'>"
			+ "</a>"
			+ "</div>";
		
		return it;
	}
	
	
});

</script>

</body>
</html>