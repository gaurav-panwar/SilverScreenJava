var count=0;
$(document).ready(function() {

	$("#location").html($("#locate").val());
	if(localStorage.getItem("location")==null || localStorage.getItem("location")== "undefined"){
		$("#myModal").modal('show');
	}

	if ($.cookie("userCookie") == null) {
		console.log("null");
		$("#recomMain").hide();
		$("#log").html('<a href="#" data-target="#login-modal" role="button" data-toggle="modal">Login/SignUp</a>');
	} 
	else {
		
		$("#log").html(' <a href="#" class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span><span class="caret"></span></a><ul class="dropdown-menu"><li><a href="/SilverScreenMavenProject/bookingHistory">Booking History</a></li><li><a href="/SilverScreenMavenProject/editpage">Settings</a></li><li><a href="#" onclick="signOut();">SignOut</a></li></ul>');
		/*//alert("recommend");*/
		$.get("/SilverScreenMavenProject/bhistory",function(data,status){
		
			
				data=JSON.parse(data);
			
				var i=0;
				var ar=[];
				var arr=[0,0,0,0,0,0,0,0,0,0,0,0,0];
				var mx = 0, idx = 0;
				
				$.each(data,function(key,value){
					
					if(ar.indexOf(value['movie_show']['movie']['m_genre'])==-1)
						{
					
						ar.push(value['movie_show']['movie']['m_genre']);
						arr[i]++;
						i++;
						}
					else{
						var p=ar.indexOf(value['movie_show']['movie']['m_genre']);
						arr[p]++;
					}
					});
				for(i=1;i<arr.length;i++)
					{
					if(arr[i]>arr[idx])
						{
						mx=arr[i];
						idx=i;
						}
					}
					
				var genre=ar[idx];
				console.log("genre"+ genre);
				if(genre != null || genre != "" || genre != "undefined"){
					
					 recommend(genre); 
				}
				else{
					$("#recomMain").hide();
				}
				
		          
			
				
		});
		
		function recommend(genre)
		{
			$.ajax({
				url:"/SilverScreenMavenProject/recommend",
				type:"GET",
				data:{genre},

				success:function(data){
					////alert("recommend : success")
					
					data=JSON.parse(data);
					console.log(data);
					
					$("#recommendation").html("Recommendation");
					
					for(var i=0;i<data.length;i++){
						var id=data[i]["m_id"];
						var link=data[i]["m_trailer"];
						var name=data[i]["m_name"];
						console.log(link);
						console.log(name);
						$("#recommended").append("<li><a href='/SilverScreenMavenProject/movieDetails/"+id+"'>"+name+"</a></li>");
						console.log("added");
						}
					
					},
				error: function() {
					$("#recomMain").hide();
				}
		});
		}

	}
	$("#enter-button").click(function() {
		var loc=$("#locate option:selected").val();
		localStorage.setItem("location",loc);
		$("#location").html($("#locate").val());
		location.reload();

	});

	$.get("/SilverScreenMavenProject/carousel1",function(data,status){
		var normalData = JSON.parse(data);
		var id=normalData[0].m_id;
		var image=(normalData[0].m_cover);
		$("#carousel1-1").html('<a href="/SilverScreenMavenProject/movieDetails/'+id+'"> <img class="firstcarouselimage" src="'+image+'"></a>');
		var id2=normalData[1].m_id;
		var image2=(normalData[1].m_cover);
		$("#carousel1-2").html('<a href="/SilverScreenMavenProject/movieDetails/'+id2+'"> <img class="firstcarouselimage" src="'+image2+'"></a>');
		var id3=normalData[2].m_id;
		var image3=(normalData[2].m_cover);
		$("#carousel1-3").html('<a href="/SilverScreenMavenProject/movieDetails/'+id3+'"> <img class="firstcarouselimage" src="'+image3+'"></a>');

		var id4=normalData[3].m_id;
		var image4=(normalData[3].m_cover);
		$("#carousel1-4").html('<a href="/SilverScreenMavenProject/movieDetails/'+id4+'"> <img class="firstcarouselimage" src="'+image4+'"></a>');

	});



	$.get("/SilverScreenMavenProject/topmovies",function(data,status){
		
		var normalData=JSON.parse(data);
		$("#topmovies tbody").text("");
		/*if(count==0){*/
		for(var i=0;i<10;i++){
			count++;
			var name= normalData[i].m_name;
			var m_id=normalData[i].m_id;
			$('#tp'+i).html("<i class='fa fa-film'></i><a href='/SilverScreenMavenProject/movieDetails/"+m_id+"'>&nbsp; &nbsp; "+name+"</a>")
			
		}/*}*/
		
		var id=normalData[0].m_id;
		var image=(normalData[0].m_poster);
		var name=(normalData[0].m_name);
		var trailer=(normalData[0].m_trailer);
		var language=(normalData[0].m_language);
		var genre=(normalData[0].m_genre);
		$("#carousel2-1-1").html("<img class='mv-icon' src='"+image+"'><div class='hover-btn'><a class='trailer-link' href='"+trailer+"'><span class='glyphicon glyphicon-play-circle btn-play'></span></a></div><b>"+name+"</b><br>"+language+"<br>"+genre+"<br><a href='showList/"+id+"'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");

		var id1=normalData[1].m_id;
		var image1=(normalData[1].m_poster);
		var name1=(normalData[1].m_name);
		var trailer1=(normalData[1].m_trailer);
		var language1=(normalData[1].m_language);
		var genre1=(normalData[1].m_genre);
		$("#carousel2-1-2").html("<img class='mv-icon' src='"+image1+"'><div class='hover-btn'><a class='trailer-link' href='"+trailer1+"'><span class='glyphicon glyphicon-play-circle btn-play'></span></a></div><b>"+name1+"</b><br>"+language1+"<br>"+genre1+"<br><a href='showList/"+id1+"'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");

		var id2=normalData[2].m_id;
		var image2=(normalData[2].m_poster);
		var name2=(normalData[2].m_name);
		var trailer2=(normalData[2].m_trailer);
		var language2=(normalData[2].m_language);
		var genre2=(normalData[2].m_genre);
		$("#carousel2-1-3").html("<img class='mv-icon' src='"+image2+"'><div class='hover-btn'><a class='trailer-link' href='"+trailer2+"'><span class='glyphicon glyphicon-play-circle btn-play'></span></a></div><b>"+name2+"</b><br>"+language2+"<br>"+genre2+"<br><a href='showList/"+id2+"'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");

		var id3=normalData[3].m_id;
		var image3=(normalData[3].m_poster);
		var name3=(normalData[3].m_name);
		var trailer3=(normalData[3].m_trailer);
		var language3=(normalData[3].m_language);
		var genre3=(normalData[3].m_genre);
		$("#carousel2-2-1").html("<img class='mv-icon' src='"+image3+"'><div class='hover-btn'><a class='trailer-link' href='"+trailer3+"'><span class='glyphicon glyphicon-play-circle btn-play'></span></a></div><b>"+name3+"</b><br>"+language3+"<br>"+genre3+"<br><a href='showList/"+id3+"'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");


		var id4=normalData[4].m_id;
		var image4=(normalData[4].m_poster);
		var name4=(normalData[4].m_name);
		var trailer4=(normalData[4].m_trailer);
		var language4=(normalData[4].m_language);
		var genre4=(normalData[4].m_genre);
		$("#carousel2-2-2").html("<img class='mv-icon' src='"+image4+"'><div class='hover-btn'><a class='trailer-link' href='"+trailer4+"'><span class='glyphicon glyphicon-play-circle btn-play'></span></a></div><b>"+name4+"</b><br>"+language4+"<br>"+genre4+"<br><a href='showList/"+id4+"'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");


		var id5=normalData[5].m_id;
		var image5=(normalData[5].m_poster);
		var name5=(normalData[5].m_name);
		var trailer5=(normalData[5].m_trailer);
		var language5=(normalData[5].m_language);
		var genre5=(normalData[5].m_genre);
		$("#carousel2-2-3").html("<img class='mv-icon' src='"+image5+"'><div class='hover-btn'><a class='trailer-link' href='"+trailer5+"'><span class='glyphicon glyphicon-play-circle btn-play'></span></a></div><b>"+name5+"</b><br>"+language5+"<br>"+genre5+"<br><a href='showList/"+id5+"'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");

		var id6=normalData[6].m_id;
		var image6=(normalData[6].m_poster);
		var name6=(normalData[6].m_name);
		var trailer6=(normalData[6].m_trailer);
		var language6=(normalData[6].m_language);
		var genre6=(normalData[6].m_genre);
		$("#carousel2-3-1").html("<img class='mv-icon' src='"+image6+"'><div class='hover-btn'><a class='trailer-link' href='"+trailer6+"'><span class='glyphicon glyphicon-play-circle btn-play'></span></a></div><b>"+name6+"</b><br>"+language6+"<br>"+genre6+"<br><a href='showList/"+id6+"'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");

		var id7=normalData[7].m_id;
		var image7=(normalData[7].m_poster);
		var name7=(normalData[7].m_name);
		var trailer7=(normalData[7].m_trailer);
		var language7=(normalData[7].m_language);
		var genre7=(normalData[7].m_genre);
		$("#carousel2-3-2").html("<img class='mv-icon' src='"+image7+"'><div class='hover-btn'><a class='trailer-link' href='"+trailer7+"'><span class='glyphicon glyphicon-play-circle btn-play'></span></a></div><b>"+name7+"</b><br>"+language7+"<br>"+genre7+"<br><a href='showList/"+id7+"'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");

		var id8=normalData[8].m_id;
		var image8=(normalData[8].m_poster);
		var name8=(normalData[8].m_name);
		var trailer8=(normalData[8].m_trailer);
		var language8=(normalData[8].m_language);
		var genre8=(normalData[8].m_genre);
		$("#carousel2-3-3").html("<img class='mv-icon' src='"+image8+"'><div class='hover-btn'><a class='trailer-link' href='"+trailer8+"'><span class='glyphicon glyphicon-play-circle btn-play'></span></a></div><b>"+name8+"</b><br>"+language8+"<br>"+genre8+"<br><a href='showList/"+id8+"'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");

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
	$.get("/SilverScreenMavenProject/topmovies",function(data,status){

		var normalData=JSON.parse(data);
		for(var i=0;i<10;i++){
			var name=normalData[i].m_name;
			var m_id=normalData[i].m_id;
			$("#topmovies").append("<li><i class='fa fa-film'></i><a href='/SilverScreenMavenProject/movieDetails/"+m_id+"'>&nbsp; &nbsp; "+name+"</a></li>");

		
			
		}
		var id = normalData[0].m_id;
		var image = (normalData[0].m_poster);
		var name = (normalData[0].m_name);
		var trailer = (normalData[0].m_trailer);
		var language = (normalData[0].m_language);
		var genre = (normalData[0].m_genre);
		$("#carousel2-1-1").html("<img class='mv-icon' src='" + image + "'>"
			+ "<div class='hover-btn'>"
			+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
			+ " onclick='showTrailer(this);' id='mv-sp-" + trailer + "'></span>"
			+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + id + "' >"
			+ "<span class='glyphicon glyphicon-info-sign'></span></a></div>"
			+ "<b>" + name + "</b><br>" + language + "<br>" + genre 
			+ "<br><a href='/SilverScreenMavenProject/showList/" + id + "'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");


		var id1=normalData[1].m_id;
		var image1=(normalData[1].m_poster);
		var name1=(normalData[1].m_name);
		var trailer1=(normalData[1].m_trailer);
		var language1=(normalData[1].m_language);
		var genre1=(normalData[1].m_genre);
		$("#carousel2-1-2").html("<img class='mv-icon' src='" + image1 + "'>"
			+ "<div class='hover-btn'>"
			+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
			+ " onclick='showTrailer(this);' id='mv-sp-" + trailer1 + "'></span>"
			+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + id1 + "' >"
			+ "<span class='glyphicon glyphicon-info-sign'></span></a></div>"
			+ "<b>" + name1 + "</b><br>" + language1 + "<br>" + genre1
			+ "<br><a href='/SilverScreenMavenProject/showList/" + id1 + "'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");
		

		var id2=normalData[2].m_id;
		var image2=(normalData[2].m_poster);
		var name2=(normalData[2].m_name);
		var trailer2=(normalData[2].m_trailer);
		var language2=(normalData[2].m_language);
		var genre2=(normalData[2].m_genre);
		$("#carousel2-1-3").html("<img class='mv-icon' src='" + image2 + "'>"
			+ "<div class='hover-btn'>"
			+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
			+ " onclick='showTrailer(this);' id='mv-sp-" + trailer2 + "'></span>"
			+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + id2 + "' >"
			+ "<span class='glyphicon glyphicon-info-sign'></span></a></div>"
			+ "<b>" + name2 + "</b><br>" + language2 + "<br>" + genre2 
			+ "<br><a href='/SilverScreenMavenProject/showList/" + id2 + "'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");
		


		var id3=normalData[3].m_id;
		var image3=(normalData[3].m_poster);
		var name3=(normalData[3].m_name);
		var trailer3=(normalData[3].m_trailer);
		var language3=(normalData[3].m_language);
		var genre3=(normalData[3].m_genre);
		$("#carousel2-2-1").html("<img class='mv-icon' src='" + image3 + "'>"
			+ "<div class='hover-btn'>"
			+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
			+ " onclick='showTrailer(this);' id='mv-sp-" + trailer3 + "'></span>"
			+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + id3 + "' >"
			+ "<span class='glyphicon glyphicon-info-sign'></span></a></div>"
			+ "<b>" + name3 + "</b><br>" + language3 + "<br>" + genre3 
			+ "<br><a href='/SilverScreenMavenProject/showList/" + id3 + "'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");



		var id4=normalData[4].m_id;
		var image4=(normalData[4].m_poster);
		var name4=(normalData[4].m_name);
		var trailer4=(normalData[4].m_trailer);
		var language4=(normalData[4].m_language);
		var genre4=(normalData[4].m_genre);
		$("#carousel2-2-2").html("<img class='mv-icon' src='" + image4 + "'>"
			+ "<div class='hover-btn'>"
			+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
			+ " onclick='showTrailer(this);' id='mv-sp-" + trailer4 + "'></span>"
			+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + id4 + "' >"
			+ "<span class='glyphicon glyphicon-info-sign'></span></a></div>"
			+ "<b>" + name4 + "</b><br>" + language4 + "<br>" + genre4 
			+ "<br><a href='/SilverScreenMavenProject/showList/" + id4 + "'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");

		var id5=normalData[5].m_id;
		var image5=(normalData[5].m_poster);
		var name5=(normalData[5].m_name);
		var trailer5=(normalData[5].m_trailer);
		var language5=(normalData[5].m_language);
		var genre5=(normalData[5].m_genre);
		$("#carousel2-2-3").html("<img class='mv-icon' src='" + image5 + "'>"
			+ "<div class='hover-btn'>"
			+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
			+ " onclick='showTrailer(this);' id='mv-sp-" + trailer5 + "'></span>"
			+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + id5 + "' >"
			+ "<span class='glyphicon glyphicon-info-sign'></span></a></div>"
			+ "<b>" + name5 + "</b><br>" + language5 + "<br>" + genre5 
			+ "<br><a href='/SilverScreenMavenProject/showList/" + id5 + "'><button class='btn-book' type='button'><b>BOOK NOW</b></button></a></div>");
		

		var id6=normalData[6].m_id;
		var image6=(normalData[6].m_poster);
		var name6=(normalData[6].m_name);
		var trailer6=(normalData[6].m_trailer);
		var language6=(normalData[6].m_language);
		var genre6=(normalData[6].m_genre);
		$("#carousel2-3-1").html("<img class='mv-icon' src='" + image6 + "'>"
			+ "<div class='hover-btn'>"
			+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
			+ " onclick='showTrailer(this);' id='mv-sp-" + trailer6 + "'></span>"
			+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + id6 + "' >"
			+ "<span class='glyphicon glyphicon-info-sign'></span></a></div>"
			+ "<b>" + name6 + "</b><br>" + language6 + "<br>" + genre6
			+ "<br><a href='/SilverScreenMavenProject/showList/" + id6 + "'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");


		var id7=normalData[7].m_id;
		var image7=(normalData[7].m_poster);
		var name7=(normalData[7].m_name);
		var trailer7=(normalData[7].m_trailer);
		var language7=(normalData[7].m_language);
		var genre7=(normalData[7].m_genre);
		$("#carousel2-3-2").html("<img class='mv-icon' src='" + image7 + "'>"
			+ "<div class='hover-btn'>"
			+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
			+ " onclick='showTrailer(this);' id='mv-sp-" + trailer7 + "'></span>"
			+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + id7 + "' >"
			+ "<span class='glyphicon glyphicon-info-sign'></span></a></div>"
			+ "<b>" + name7 + "</b><br>" + language7 + "<br>" + genre7 
			+ "<br><a href='/SilverScreenMavenProject/showList/" + id7 + "'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");


		var id8=normalData[8].m_id;
		var image8=(normalData[8].m_poster);
		var name8=(normalData[8].m_name);
		var trailer8=(normalData[8].m_trailer);
		var language8=(normalData[8].m_language);
		var genre8=(normalData[8].m_genre);
		$("#carousel2-3-3").html("<img class='mv-icon' src='" + image8 + "'>"
			+ "<div class='hover-btn'>"
			+ "<span class='glyphicon glyphicon-play-circle btn-play' data-toggle='modal' data-target='#trailerModal'"
			+ " onclick='showTrailer(this);' id='mv-sp-" + trailer8 + "'></span>"
			+ "<a class='btn-info' href='" + "/SilverScreenMavenProject/movieDetails/" + id8 + "' >"
			+ "<span class='glyphicon glyphicon-info-sign'></span></a></div>"
			+ "<b>" + name8 + "</b><br>" + language8 + "<br>" + genre8 
			+ "<br><a href='/SilverScreenMavenProject/showList/" + id8 + "'><button class='btn-book' type='button'>BOOK NOW</button></a></div>");

	});


$("#trailerModal").on('hide.bs.modal', function() {
				$("#trailerVideo").attr('src', '');
			});

	
});

function showTrailer(tmp) {
	var str = tmp.id;
	var id = str.substring(6);
	
	console.log("Running " + id);
	
	$('#trailerVideo').attr("src", id);
	$('#trailerModal').show();
}

