/**
 * 
 */
$(document).ready(function(){
	
	$("#location").html($("#locate").val());

	$("#enter-button").click(function() {
		var loc=$("#locate option:selected").val();
		localStorage.setItem("location",loc);
		$("#location").html($("#locate").val());
		location.reload();

	});
			       
		$.get("/SilverScreenMavenProject/bhistory",function(data,status){
			console.log(data);
			data=JSON.parse(data);
			$.each(data,function(key,value){
				var name=value['movie_show']['movie']['m_name'];
				var language=value['movie_show']['movie']['m_language'];
				var seats_booked=value['seats_booked'];
				var genre=value['movie_show']['movie']['m_genre'];
				var row=$("<tr/>");
				row.append($("<td/>").append(name));
				row.append($("<td/>").append(language));
				row.append($("<td/>").append(seats_booked));
				row.append($("<td/>").append(genre));
				$("#results").append(row);
			});
			
		});
		
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