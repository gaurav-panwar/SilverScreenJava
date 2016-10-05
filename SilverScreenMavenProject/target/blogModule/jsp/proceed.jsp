<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Proceed page</title>
<link
	href="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet">

<script
	src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" />"></script>
<script
	src="<c:url value="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" />"></script>
<script
	src="<c:url value="https://use.fontawesome.com/4db7f356f3.js" />"></script>
<style type="text/css">
.back {
	padding: 0px;
	height: 100%;
	background-color: #f2f2f2;
}

.row {
	margin: 0;
}

.header {
	width: 100%;
	height: auto;
	background-color: #1f2533;
}

.movie_info {
	padding: 10px 20px 10px 50px;
	color: #49ba8e;
	width: 100%;
}

.movie_name {
	margin-top: 10px;
}

.movie_detail {
	margin-bottom: 0px;
}

.pay {
	height: 400px;
	background-color: transparent;
}

.summary {
	padding-top: 30px;
	background-color: white;
}

#timer {
	width: 50px;
	height: 50px;
	border: 2px solid #89B0AE;
	border-radius: 50%;
	text-align: center;
	background-color: #BEE3DB;
	color: #FAF9F9;
	font-weight: bold;
	padding-top: 10px;
}

.glyphicon.glyphicon-chevron-left {
	position: absolute;
	top: 37px;
	left: 10px;
	font-size: 30px;
	color: #f2f2f2;
}

button.accordion {
	background-color: #cccccc;
	color: #444;
	cursor: pointer;
	padding: 18px;
	width: 100%;
	border: none;
	text-align: left;
	outline: none;
	font-size: 15px;
	transition: 0.4s;
}

button.accordion.active, button.accordion:hover {
	background-color: #49ba8e;
}

button.accordion:after {
	content: '\02795';
	font-size: 13px;
	color: #777;
	float: right;
	margin-left: 5px;
}

button.accordion.active:after {
	content: "\2796";
}

div.panel {
	padding: 10 18px;
	margin-bottom: 0px;
	background-color: white;
	max-height: 0;
	overflow: hidden;
	transition: 0.6s;
	opacity: 0;
}

div.panel.show {
	opacity: 1;
	max-height: 500px;
	padding: 10px 20px, 10px, 20px;
}

.f {
	text-align: center;
	padding-top: 10px;
	padding-bottom: 10px;
	padding-left: 10px;
	padding-right: 10px;
}

.form-control {
	padding: 10px;
}

.placeholder {
	color: black;
}

.form-control {
	padding: 10px 10px 0px 10px;
	margin-top: 10px;
	margin-bottom: 10px;
}

.ff {
	text-align: center;
	margin-top: 0px;
	padding-top: 0px;
	font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
}

.total {
	background-color: orange;
	margin: 20px 0 20px 0;
}

.no_tickets {
	font-size: 15px;
}

@media ( max-width : 768px ) {
	h2 {
		font-size: 1.8em;
	}
	h4 {
		font-size: 1.4em;
	}
}

@media ( min-width :768px )and(max-width: 992px ) {
	h2 {
		font-size: 2.1em;
	}
	h4 {
		font-size: 1.7em;
	}
}

@media ( min-width : 992px )and(max-width: 1200px) {
	h2 {
		font-size: 2.4em;
	}
	h4 {
		font-size: 2em;
	}
}

@media ( min-width : 1200px ) {
	h2 {
		font-size: 2.6em;
	}
	h4 {
		font-size: 2.3 em;
	}
}
</style>
<script type="text/javascript">

$m=10;
$t=0;

function startTime()
{
	
	$m=checkTime($m);
	$t=checkTime($t);
	document.getElementById("timer").innerHTML=$m+":"+$t;
	$m=parseInt($m);
	$t=parseInt($t);
	if($t==0&&$m==0)
	{
	$("#myModal").modal("show");
	
	}
	else{
		$t=$t-1;
		if($t<0)
			{
			$m=$m-1;
			$t=59;
			
			}
		var x=setTimeout(function(){startTime()},1000);
		
	}
	
	
}
	
	
	
	

function checkTime(i)
{
	if(i<10)
		i="0"+i;
	return i;
	
	}


</script>

</head>
<body onbeforeunload="alert('function alrt WORKS !!!!')">

	<div class="container-fluid back">
		<div class="header">
			<span><a class="glyphicon glyphicon-chevron-left" href="#"
				style="text-decoration: none;"></a></span>
			<div class="movie_info">
				<h4 class="movie_name"></h4>
				<p class="movie_detail"></p>

			</div>

		</div>
		<div class="row ">
			<br>
			<div class="col-xs-8 col-sm-8 col-md-8 pay">
				<button class="accordion">Share your Contact</button>
				<div class="panel">
					<form class="form-inline f">
						<input class="form-control" type="email" name="emailId" id="inputemail"
							placeholder="Email Address"> <input class="form-control" id="inputphone"
							type="text" name="mNo" placeholder="Mobile No."
							pattern="^[789]/d{9}$" maxlength="10">
						<button class="btn btn-danger" id="inputsubmit">SUBMIT</button>
					</form>
					<div class="or">
						<div
							class="col-xs-offset-5 col-xs-2 col-sm-offset-5 col-sm-2 col-md-offset-5 col-md-2">
							<h2 class="ff">OR</h2>
						</div>
						<div
							class=" text-center col-xs-offset-3 col-xs-6 col-sm-offset-3 col-sm-6 col-md-offset-3 col-md-6 btn btn-danger"
							style="margin-bottom: 10px;" type="button">LOGIN</div>
					</div>

				</div>

				<button class="accordion">Payment Option</button>
				<div class="panel">
					<form class="f col-md-9" action="databasecommit">
						
						<div class="form">
							<input class="form-control col-md-offset-2 col-md-8" type="text"
								id="CardNo" name="CardNo" placeholder="Enter Your Card Number">
						</div>
						<div class="form">
							<input class="form-control col-md-offset-2 col-md-8" type="text"
								id="CardName" name="CardName" placeholder="Name On The Card">
						</div>
						<div class="form">
							<input class="form-control col-md-offset-2 col-md-8" type="num"
								maxlength="4" id="CardMonth" name="CardMonth"
								placeholder="Expiry Date(MM/YY) ">
						</div>
						<div class="form">
							<input class="form-control col-md-offset-2 col-md-8" type="num"
								maxlength="4" id="CvvNo" name="CvvNo" placeholder="CVV">
						</div>
						<input type="hidden" name="ms_id" value="" id="ms_id"> 
						<input type="hidden" name="seats" value="" id="seats">
						<input type="hidden" name="hiddenemail" value="" id="hiddenemail"> 
						<input type="hidden" name="hiddenphone" value="" id="hiddenphone">
						
						<div class="form">
							<input class="col-md-offset-4 col-md-8 btn btn-danger"
								type="submit">

						</div>

					</form>
				</div>
				<script type="text/javascript">
									var acc = document.getElementsByClassName("accordion");
									var i;

									for (i = 0; i < acc.length; i++) {
										acc[i].onclick = function(){
											this.classList.toggle("active");
											this.nextElementSibling.classList.toggle("show");
										}
									}
								</script>

			</div>
			<div class="col-xs-4 col-sm-4 col-md-4 summary">
				<div class="row">
					<div class="col-md-8">
						<h3>ORDER SUMMARY</h3>
					</div>
					<br>
					<div class="col-md-8 ">
						<b><h4 class="movie_name">Movie Name</h4></b>
					</div>
					<div class="col-md-8 ">
						<h6 id="abt_movie">Language, format</h6>
					</div>
					<span class="col-md-4 text-center no_tickets">
				</div>
				</span>
				<div class="col-md-8" id="cinema_name">
					<h6>Cinema Name</h6>
				</div>
				<div class="col-md-8 ">
					<h5 id="seat_alloted">
						A1, B1, C1<br>Date<br>Time
					</h5>
				</div>
				<div class="separator"></div>
				<br>
				<div class="col-md-9">Sub Total</div>
				<div class="col-md-3 ticket_A"></div>
				<br>
				<div class="col-md-9">+Internet Handling Fees</div>
				<div class=" col-md-3 ">Re. 25.6</div>
				<div class="col-md-12 total">
					<h5 class="col-md-6 ">Amount Payable</h5>
					<h4 class="col-md-6 text-center payable"></h4>
				</div>
				<div class="col-xs-4">
				</div>
				<div class="col-xs-5">

					<div id="timer"></div>
					<br>
					<div class="modal fade" id="myModal" role="dialog"
						data-backdrop="static" data-keyboard="false">
						<div class="modal-dialog">


							<div class="modal-content">
								<div class="modal-header" style="font-weight:bold;background-color: #101935; color:#F2FDFF ;text-align: center;">
									<div class="modal-title" >
									<h2  style="padding-bottom: 0;	 ">Sorry,Your time is up</h2><br>
										
									</div>
								</div>
								<div class="modal-body">
									<h4 style="text-align: center;">Click the following button to redirect to prevoius
										page</h4/>
									<div class="col-xs-12">
									<div class="col-xs-8"></div>
									<a class="btn btn-danger col-xs-4" href="transaction" >Movies Page</a>
									</div>
								</div>

							</div>

						</div>
					</div>


				</div>

			</div>
			<script type="text/javascript">
			window.onbeforeunload = function() {
			    return "Dude, you can't";}
			
			$("#inputsubmit").click(function(){
				var x=$("#inputemail").val();
				var y=$("#inputphone").val();
				
				$("#hiddenemail").val($("#inputemail").val());
				$("#hiddenphone").val($("#inputphone").val());
				
				
			});
			
								window.onload = function() {
									startTime();
											$("#ms_id").val(${ms_id});
											$("#seats").val("${seats}");
									/* alert(${seat1});
									alert(${seat2});
									alert(${seat3});
									alert(${seat4}); */
									
									
									/* var str=""; */
									/* var len=parseInt(${length});
									for(var i=0;i<len;i++)
										{
										switch((i+1))
											{
											case 1:
												str+=${seat1};
												break;
											case 2:
												str+=${seat2};
												break;
											case 3:
												str+=${seat3};
												break;
											case 4:
												str+=${seat4};
												break;
											case 5:
												str+=${seat5};
												break;
											case 6:
												str+=${seat6};
												break;
											case 7:
												str+=${seat7};
												break;
											case 8:
												str+=${seat8};
												break;
											case 9:
												str+=${seat9};
												break;
											case 10:
												str+=${seat10};
												break;
												
												
											}
									 */
										
									/* 	} */
									
									$.get("showMovieShowDetail/"+${ms_id},function(data,status){
										
										alert(data);
										data=JSON.parse(data);
										
										var  movieName=data["movie"]["m_name"];
										
										var format= data["movie"]["m_format"];
										var lang= data["movie"]["m_language"];
										var x = new Date(
												data["ms_timestamp"]);
										var t = x.getHours();
										t += ":";
										t += x.getMinutes();
										var time=t;
										var date= x.toDateString();
										var day;
										var cinemaName=data["audi"]["cinema"]["c_name"]+" , "+data["audi"]["cinema"]["c_location"];
										var noTicket=${length};
										var seatAlloted="A5 A6";
										var sa=parseInt(data["ms_price"])*parseInt(${length});
                                        $(".ticket_A").text("Rs."+sa);
                                        sa+=25.60;
                                        $(".payable").text("Rs."+sa);
										$(".movie_name").text(movieName);
										$(".movie_detail").html(lang+' | '+format+' | '+date+','+time+'<br>'+cinemaName);
										$("#abt_movie").text(lang+", "+format);
										$("#cinema_name").html(cinemaName);
										$(".no_tickets").html(noTicket+"<br><b>Tickets</b>");
										$("#seat_alloted").text("${seats}");
										
									});
									


								};


							</script>
		</div>
	</div>

</body>
</html>