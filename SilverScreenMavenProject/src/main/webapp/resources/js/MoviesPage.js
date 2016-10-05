$(function() {
	
	initialize();
	
	function initialize() {
		var loc = localStorage.location;
		$('#location').text(loc);
		$('#main-ComingSoon').hide();
		$('.ErrorMessage').hide();
	}
	
	$('#btn-NowShowing').click(function() {
		$(this).addClass('active');
		$('#main-NowShowing').show();
		$('#btn-ComingSoon').removeClass('active');
		$('#main-ComingSoon').hide();
	});
	
	
	$('#btn-ComingSoon').click(function() {
		$(this).addClass('active');
		$('#main-ComingSoon').show();
		$('#btn-NowShowing').removeClass('active');
		$('#main-NowShowing').hide();
	});
	
	
	
	//alternative to above functions
	$('#main-filters').click(function () {
		var len_l = 0, len_g = 0, len_f = 0;
		var list_lang = [], list_gen = [], list_form = [];
		$('.movie-tile').hide();
		$('.ErrorMessage').hide();
		
		
		
		$("input[name='lang-filter']:checked").each(function() {
			list_lang.push($(this).val());
		});
		len_l = list_lang.length;
		
		$("input[name='genre-filter']:checked").each(function() {
			list_gen.push($(this).val());
		});
		len_g = list_gen.length;
		
		$("input[name='format-filter']:checked").each(function() {
			list_form.push($(this).val());
		});
		len_f = list_form.length;
		console.log(len_f + ", " + len_g + ", " + len_l);
		
		if(len_f !=0 && len_g !=0 && len_l !=0) {
			for(var i=0; i<len_l; ++i) {
				for(var j=0; j<len_g; ++j) {
					for(var k=0; k<len_f; ++k) {
						$(".mv-lang-" + list_lang[i] + ".mv-gen-" + list_gen[j] + ".mv-form-" + list_form[k]).show();
					}
				}
			}
		}
		else if(len_f == 0 && len_g !=0 && len_l !=0) {
			for(i=0; i<len_l; ++i){
				for(j=0; j<len_g; ++j) {
					$(".mv-lang-" + list_lang[i] + ".mv-gen-" + list_gen[j]).show();
				}
			}
		}
		else if(len_f != 0 && len_g == 0 && len_l != 0) {
			for(i=0; i<len_l; ++i){
				for(j=0; j<len_f; ++j) {
					$(".mv-lang-" + list_lang[i] + ".mv-form-" + list_form[j]).show();
				}
			}
		}
		else if(len_f != 0 && len_g != 0 && len_l == 0) {
			for(i=0; i<len_g; ++i){
				for(j=0; j<len_f; ++j) {
					$(".mv-gen-" + list_gen[i] + ".mv-form-" + list_form[j]).show();
				}
			}
		}
		else if(len_f != 0 && len_g == 0 && len_l == 0) {
			for(i=0; i<len_f; ++i)
				$(".mv-form-" + list_form[i]).show();
		}
		else if(len_f == 0 && len_g != 0 && len_l == 0) {
			for(i=0; i<len_g; ++i)
				$(".mv-gen-" + list_gen[i]).show();
		}
		else if(len_f == 0 && len_g == 0 && len_l != 0) {
			for(i=0; i<len_l; ++i)
				$(".mv-lang-" + list_lang[i]).show();
		}
		else {
			$('.ErrorMessage').show();
		}
		
		if((len_g + len_f + len_l) == 0) {
			$('.movie-tile').show();
			$('.ErrorMessage').hide();
		}
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