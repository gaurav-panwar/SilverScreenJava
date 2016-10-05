<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Movies page Id</title>
<link
	href="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/MoviePageIdcss.css" />"
	rel="stylesheet">
<script
	src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" />"></script>
<script
	src="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" />"></script>
<script
	src="<c:url value="https://use.fontawesome.com/4db7f356f3.js" />"></script>

<script type="text/javascript">
	
	$(document).ready(function() {

		$.get("/SilverScreenMavenProject/showMovie/"+${m_id},function(data,status){
			alert(data);
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
                  
			$("#myModal").on('hide.bs.modal', function() {
				$("#cartoonVideo").attr('src', '');
			});

			$("#myModal").on('show.bs.modal', function() {
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
				var path = "C:\\Users\\Parveen\\Desktop\\usersample.png";
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
			alert(userRating);
		});
		

	});
</script>


</head>

<body>
	<div class="container-fluid">
		<div class="page-header">
			<div class="video-container">
					<div id="video-back" 
						style="position: relative;">
						<img src="" class="img-responsive" id="back">
					</div>
					<div id=play style="position: absolute;" data-toggle="modal" data-target="#myModal">
						<img src="<c:url value="/resources/images/play.png"/>"
							class="img-responsive">
					</div>
				<div id="myModal" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">×</button>
								<h4 class="modal-title" >TRAILER</h4>
							</div>
							<div class="modal-body">
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
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#summary"
							style="font-size: 1.5vw;">Summary</a></li>
						<li><a data-toggle="tab" href="#userreview"
							style="font-size: 1.5vw;">User Review</a></li>
						<li><a data-toggle="tab" href="#castandcrew"
							style="font-size: 1.5vw;">Cast And Crew</a></li>

					</ul>

					<div class="tab-content">
						<div id="Summary" class="tab-pane fade in active">
							<h1 style="font-size: 2vw;margin: 10px;">SUMMARY</h1>
							<div class="summary" style="font-size: 1.5vw; margin: 10px;"></div>
						</div>
						<div id="userreview" class="tab-pane fade in tabs">
							<h1 style="font-size: 3vw;">User Review</h1>
						</div>
						<div id="castandcrew" class="tab-pane fade in ">
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

</body>
</html>