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

<script type="text/javascript">
$(window).load(function(){
	$("#myModal").modal("show");
});

$(document).ready(function(){
	
	 $.get("showBookingDetail/"+${bd_id},function(data,status){
		 alert(data);
		 data=JSON.parse(data);
		 
		 $("#email").text(data["booking"]["b_email"]);
		 $("#phone").text(data["booking"]["b_number"]);
		 $("#bookingid").text(data["bd_id"]);
		 $("#seatsbooked").text(data["seats_booked"]);
		 $("#movieshowid").text(data["movie_show"]["ms_id"]);
		 $("#moviename").text(data["movie_show"]["movie"]["m_name"]);
		 $("#cinema").text(data["movie_show"]["audi"]["cinema"]["c_name"]);
		 $("#location").text(data["movie_show"]["audi"]["cinema"]["c_location"]);
		$("#total").text(${length});
		$("#price").text(data["movie_show"]["ms_price"]);
		var t=${length};
		var total=parseInt(data["movie_show"]["ms_price"]*t);
		$("#totalprice").text(("Rs.")+(total));
		$("#payable").text(("Rs.")+(total+25.60));
		var s=new Date(data["movie_show"]["ms_timestamp"]);
		$("#movietiming").text(s);
		
		 
		 
		 
		
	 });
		
	});


</script>
<style type="text/css">

.jumbotron{
padding-top: 0;
height:100px;
margin: 0;
background-color: #061532; color:#49ba8e ;text-align: center;
}
#main{
background-color: #F2FDFF;
text-align: center;
}
#empty{
height:100px;

margin-bottom: 0;
padding-bottom: 0;


}
</style>
</head>


<body>
<div class="container-fluid">

					<div class="jumbotron">
					<div class="col-xs-12">
					<h1 >Your Booking Details are as follow:</h1>
					</div>
					
					</div>
					<div id="empty"><h3 style="color:#5B8E7D; margin-top: 40px;text-align: center;">Transaction Details:</h3>
					
					
		<div class="row">
		
		<div class="col-xs-3"></div>
		<div class="col-xs-6" id="main">
		<table class="table table-hover">
    <thead>
      <tr>
        <th style="text-align:center;">Parameter</th>
        <th style="text-align:center;">Values</th>
        
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Email:</td>
        <td id="email"></td>
       
      </tr>
      <tr>
        <td>Phone:</td>
        <td id="phone"></td>
       
      </tr>
      <tr>
        <td>Booking Id:</td>
        <td id="bookingid"></td>
        
      </tr>
      <tr>
        <td>Seats Booked:</td>
        <td id="seatsbooked"></td>
        
      </tr>
      <tr>
        <td>Movie Show Id:</td>
        <td id="movieshowid"></td>
        
      </tr>
      <tr>
        <td>Movie Name:</td>
        <td id="moviename"></td>
        
      </tr>
      <tr>
        <td>Movie Timing:</td>
        <td id="movietiming"></td>
        
      </tr>
      <tr>
        <td>Cinema:</td>
        <td id="cinema"></td>
        
      </tr>
      <tr>
        <td>Location:</td>
        <td id="location"></td>
        
      </tr>
      <tr>
        <td>Total Tickets:</td>
        <td id="total"></td>
        
      </tr>
      <tr>
        <td>Price of a Ticket:</td>
        <td id="price"></td>
        
      </tr>
      <tr>
        <td>Total Price:</td>
        <td id="totalprice"></td>
        
      </tr>
      <tr>
        <td>Internet fees:</td>
        <td id="totalprice">Rs. 25.60</td>
        
      </tr>
      <tr>
        <td>Amount Payable</td>
        <td id="payable"></td>
        
      </tr>
      
      
      
      
      
    </tbody>
  </table>
		
		</div>
		<div class="col-xs-3"></div>
		<div class="col-xs-12" style="text-align: center; margin:30px;"><button class="btn btn-danger">To Book More</button></div></div>
		</div>			
		
					
<div class="modal fade" id="myModal" role="dialog">
						<div class="modal-dialog">


							<div class="modal-content">
								<div class="modal-header" style="font-weight:bold;background-color: #101935; color:#F2FDFF ;text-align: center;">
									<div class="modal-title" >
									<h2  style="padding-bottom: 0;">Thank You, Your Booking is Confirmed</h2><br>
										
									</div>
								</div>
								<div class="modal-body">
									<h4 style="text-align: center;">Your Booking Details are shown below</h4/>
									
									<div class="col-xs-12">
									<div class="col-xs-8"></div>
									<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
									</div>
								</div>

							</div>

						</div>
					 </div>
					
					
</div>

</body>
</html>