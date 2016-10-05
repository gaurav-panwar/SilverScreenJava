$(function() {
		//initialize
	
	initialize();
	
	function initialize() {
		$('#main-Cinemas').hide();
		$('#main-Search').hide();
	}

	$('#btn-MovieSearch').click(function() {
		$(this).addClass('active');
		$('#btn-CinemaSearch').removeClass('active');
		$('#main-Cinemas').hide();
		$('#main-Movies').show();
		
	});
	
	

	$('#btn-CinemaSearch').click(function() {
		$(this).addClass('active');
		$('#btn-MovieSearch').removeClass('active');
		$('#main-Movies').hide();
		$('#main-Cinemas').show();
	});

	$('.btn-sub-filter').click(function() {
		$(this).toggleClass('active');
	});



	$('.btn-sub-filter').click(function() {
		var ch = false;

		if($('#btn-lang-Hindi').hasClass('active')) {
			$('#tabHindi').show();
			ch = true;
		}
		else {
			$('#tabHindi').hide();
		}

		if($('#btn-lang-English').hasClass('active')) {
			$('#tabEnglish').show();
			ch = true;
		}
		else {
			$('#tabEnglish').hide();
		}
	
		if($('#btn-lang-Punjabi').hasClass('active')) {
			$('#tabPunjabi').show();
			ch = true;
		}
		else {
			$('#tabPunjabi').hide();
		}

		if($('#btn-lang-Tamil').hasClass('active')) {
			$('#tabTamil').show();
			ch = true;
		}
		else {
			$('#tabTamil').hide();
		}

		if($('#btn-lang-Telugu').hasClass('active')) {
			$('#tabTelugu').show();
			ch = true;
		}
		else {
			$('#tabTelugu').hide();
		}

		if($('#btn-lang-Bengali').hasClass('active')) {
			$('#tabBengali').show();
			ch = true;
		}
		else {
			$('#tabBengali').hide();
		}

		if($('#btn-lang-Haryanvi').hasClass('active')) {
			$('#tabHaryanvi').show();
			ch = true;
		}
		else {
			$('#tabHaryanvi').hide();
		}
		
		if(ch == false) {			
			$('.tab-lang').show();
		}
	});
	
	
	$('#searchBox').on('keyup', function () {
		
		$('#main-Search').hide();
		console.log("IN AJAX");
		var searchStr = $(this).val();
		$("#ul-SearchResults").html("");
		
		if($('#btn-MovieSearch').hasClass('active')) {
			$.ajax({
				url: "searchMovies",
				data: { str: searchStr },
				success: function(jsonStr) {
					$('#main-Search').show();
					console.log(jsonStr);
					var data = $.parseJSON(jsonStr);
					for(var i=0; i<data.length; ++i) {
						console.log(data[i].m_id + " " + data[i].m_name);
						var row = "<li><a href='showList/" + data[i].m_id + "'>" 
							+ data[i].m_name + " (" + data[i].m_certification + ") </a></li>";
						$("#ul-SearchResults").append(row);
					}
				}
			});
		}
		else {
			$.ajax({
				url: "searchCinemas",
				data: { str: searchStr },
				success: function(jsonStr) {
					$('#main-Search').show();
					console.log(jsonStr);
					var data = $.parseJSON(jsonStr);
					for(var i=0; i<data.length; ++i) {
						console.log(data[i].c_id + " " + data[i].c_name);
						var row = "<li><a href='movieList/" + data[i].c_id + "'>" //change this url for cinemas
							+ data[i].c_name + " (" + data[i].c_location + ") </a></li>";
						$("#ul-SearchResults").append(row);
					}
				}
			});
		}
	});
	

	});