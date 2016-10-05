<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Seat layout</title>
<link
	href="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/SeatsLayoutcss.css" />"
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

<script type="text/javascript">
	$global = 0;
	$temp = 0;
	var jsondata;
	var seats = [];
	var available = [];
	$(document)
			.ready(
					function() {

						$
								.get(
										"/SilverScreenMavenProject/showMovieShow/"+${ms_id},
										function(data, status) {
											console.log("getting here");
											/* //alert(data); */
											jsondata = data;
											/* //alert(jsondata); */
											
											
											data = JSON.parse(data);
											var x = data["movie"];
											$("#ms_id").val(data["ms_id"]);
											$("#myModal").modal("show");
											$(".top-movie-name").text(
													x["m_name"]);
											$(".top-movie-lang-format")
													.text(
															x["m_language"]
																	+ " | "
																	+ x["m_certification"]);
											var location = data["audi"];

											$(".top-movie-hall-location")
													.text(
															location["cinema"]["c_name"]
																	+ " : "
																	+ location["cinema"]["c_location"]);

											var x = 10;
											var y = 6;
											var li;
											var ol;
											var add = ("<ol></ol>");
											add = $(add).addClass("cabin");
											var str = data["seats_available"];
											var l = str.length;

											for (var i = 0; i < 60; i++) {
												available[i] = 0;
											}

											str = str.split(',');
											for (var i = 0; i < str.length; i++) {
												/* //alert(parseInt(str[i])); */
												available[parseInt(str[i])] = 1;
											}

											for (var i = 0; i < y; i++) {
												li = ("<li/>");
												ol = ("<ol/>");
												ol = $(ol).addClass('seats');
												for (var j = 0; j < x; j++) {

													var t = i * 10 + (j + 1);

													if (available[t] == 0)
														app = ("<li class='seat'><input type='checkbox' disabled id='"+t+"'/><label for='"+t+"'>"
																+ t + "</label</li>");
													else
														app = ("<li class='seat'><input type='checkbox' id='"+t+"'/><label for='"+t+"'>"
																+ t + "</label</li>");
													ol = $(ol).append(app);
												}

												li = $(li).append(ol);

												add = $(add).append(li);

											}
											console.log(add);

											$(".adddynamic").append(add);

											var x = new Date(
													data["ms_timestamp"]);
											var t = x.getHours();
											t += ":";
											t += x.getMinutes();

											$(".showtime").append(
													"<button class='showbutton'>"
															+ t
															+ " pm</button>")

											var app;
											var price = data["ms_price"];
											var total = 0;

											$(".hover-vehicles ol li").hide();

											$(".link-hover div a ")
													.hover(
															function() {
																$(
																		".hover-vehicles ol li")
																		.hide();

																var t = $(this)
																		.attr(
																				"href");
																$(t).show();

															});
											$(".link-hover div a")
													.click(
															function() {
																$global = parseInt(
																		$(this)
																				.text(),
																		10);
																$temp = $global;
																$(
																		".selection option[value="
																				+ $global
																				+ "]")
																		.attr(
																				'selected',
																				'selected');
															});
											$(".selection")
													.blur(
															function() {
																var te = $(
																		".selection :selected")
																		.text();
																if (te != ($global)) {
																	$global = parseInt(te);

																	$temp = $global;
																	var l = seats.length;
																	for (var i = 0; i < l; i++) {
																		$(
																				'#'
																						+ seats[i])
																				.prop(
																						'checked',
																						false);
																	}
																	seats = [];
																	$(
																			".proceed-button")
																			.css(
																					"display",
																					"none");

																	total = 0;
																	$("#total")
																			.text(
																					total);
																}
															});
											$(".seat input[type=checkbox]")
													.click(
															function() {

																var id = parseInt($(
																		this)
																		.attr(
																				"id"));
																var isin = parseInt($
																		.inArray(
																				id,
																				seats));

																if ($temp == 0
																		&& isin < 0) {
																	var l = seats.length;
																	for (var i = 0; i < l; i++) {
																		$(
																				'#'
																						+ seats[i])
																				.prop(
																						'checked',
																						false);
																	}
																	$temp = $global;
																	seats = [];
																	$(
																			".proceed-button")
																			.css(
																					"display",
																					"none");

																	total = 0;
																}

																
																if (isin < 0) {

																	$(this)
																			.prop(
																					'checked',
																					true);
																	seats
																			.push(id);
																	total += price;
																	$("#total")
																			.text(
																					"Rs."
																							+ total);
																	$temp = $temp - 1;
																	if ($temp == 0) {
																		$(
																				".proceed-button")
																				.css(
																						"display",
																						"block");
																		$("#seats").val(seats.toString());
																	}
																	

																} else {
																	$(this)
																			.prop(
																					'checked',
																					true);
																}

															});

										});

					});

	$("#proceed").click(function() {

		console.log("hello");
		
	});
</script>


</head>
<body>
	<div class="container-fluid">

		<div class="jumbotron">
			<div class="row">
				<div class="col-xs-4">
				<div class="col-xs-1">
				
				</div>	
				<div class="col-xs-1"></div>
				<div class="col-xs-10">
				
				
					<span class="col-xs-12 top-movie-name"></span> <span
						class="col-xs-12 top-movie-lang-format"></span> <span
						class="col-xs-12 top-movie-hall-location"></span>
				
				</div>
				
							</div>

				<div class="col-xs-2">
					<span style="color: white; font-size: 1.5vw">No. of Tickets</span>
					<br> <select class="selection" style="width: 90%">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
						<option value="9">9</option>
						<option value="10">10</option>

					</select>
				</div>
				<div class="col-xs-4">
					<span class="col-xs-12" style="color: white; font-size: 1.5vw">Showtime:</span>
					<div class="col-xs-12 showtime"></div>

				</div>
				<!-- <div class="col-xs-9"></div> -->
				<div class="col-xs-2 proceed-button">
					<form action="/SilverScreenMavenProject/transaction">
					<input type="hidden" name="movieid" value="" id="ms_id">
					<input type="hidden" name="seats" value="" id="seats">
					
						<button class="btn btn-danger"
							style="margin: 15px; float: right; font-size: 2vw" id="proceed"
							type="submit">PROCEED</button>
							</form>
					
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-8"></div>
			<div class="col-xs-3"
				style="background-color: #08415C; color: white; font-size: 2vw">
				<span class="col-xs-4">TOTAL:</span>
				<div class="col-xs-8" id="total"></div>
			</div>
		</div>
		<div class="modal fade in" id="myModal" role="dialog"
			data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<h1
							style="color: white; font-size: 2vw; text-align: center; padding-bottom: 2px">Select
							number of Seats:</h1>
						<div class="row link-hover">
							<div class="col-xs-1"></div>
							<div class="col-xs-1 ">
								<a href="#bicycle" class=" link-hover-a size"
									data-dismiss="modal">1</a>
							</div>
							<div class="col-xs-1">
								<a class="link-hover-a" href="#motorcycle" class="size"
									data-dismiss="modal">2</a>
							</div>
							<div class="col-xs-1">
								<a class="link-hover-a" href="#cab" class="size"
									data-dismiss="modal">3</a>
							</div>
							<div class="col-xs-1">
								<a class="link-hover-a" href="#car" class="size"
									data-dismiss="modal">4</a>
							</div>
							<div class="col-xs-1">
								<a class="link-hover-a" href="#suv" class="size"
									data-dismiss="modal">5</a>
							</div>
							<div class="col-xs-1">
								<a class="link-hover-a" href="#suv" class="size"
									data-dismiss="modal">6</a>
							</div>
							<div class="col-xs-1">
								<a class="link-hover-a" href="#bus" class="size"
									data-dismiss="modal">7</a>
							</div>
							<div class="col-xs-1">
								<a class="link-hover-a" href="#bus" class="size"
									data-dismiss="modal">8</a>
							</div>
							<div class="col-xs-1">
								<a class="link-hover-a" href="#bus" class="size"
									data-dismiss="modal">9</a>
							</div>
							<div class="col-xs-1">
								<a class="link-hover-a" href="#bus" class="size"
									data-dismiss="modal">10</a>
							</div>
							<div class="col-xs-1"></div>
						</div>
						<div class="row">
							<div class="col-xs-4"></div>
							<div class="col-xs-4 hover-vehicles">
								<ol id="all-vehicles">
									<li id="bicycle"><i class="vehicles fa fa-bicycle "
										style="font-size: 400%"></i></li>
									<li id="motorcycle"><i class="vehicles fa fa-motorcycle"
										style="font-size: 400%"></i></li>
									<li id="cab"><i class="fa fa-taxi" style="font-size: 400%"></i></li>
									<li id="car"><i class="fa fa-car" style="font-size: 400%"></i></li>
									<li id="suv"><i class="fa fa-subway"
										style="font-size: 400%"></i></li>
									<li id="suv"><i class="fa fa-subway"
										style="font-size: 400%"></i></li>
									<li id="bus"><i class="fa fa-bus" style="font-size: 400%"></i></li>

									<li id="bus"><i class="fa fa-bus" style="font-size: 400%"></i></li>
									<li id="bus"><i class="fa fa-bus" style="font-size: 400%"></i></li>
									<li id="bus"><i class="fa fa-bus" style="font-size: 400%"></i></li>
								</ol>
							</div>
							<div class="col-xs-4"></div>

						</div>



					</div>
					<div class="modal-body"></div>
					<div class="modal-footer">
						<h4 style="text-align: center; font-size: 1vw;">please at
							least select 1 seat.</h4>
					</div>
				</div>
				close

			</div>
		</div>
		<div class="row">
			<div class="col-xs-1"></div>
			<div class="col-xs-10 theater">
				<div class="audi">
					<div class="col-xs-4" id="outer">
						<div class="col-xs-12" id="day">Mon</div>
						<div class="col-xs-1"></div>
						<div class="col-xs-10" id="date">12</div>
						<div class="col-xs-1"></div>
					</div>
					<h1 style="color: #5BC0BE">Please select a seat</h1>
					<h3 style="color: #5BC0BE">All Faces This Way</h3>
				</div>

				<div class="adddynamic"></div>

			</div>
		</div>
	</div>
	
</body>
</html>