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
	
	
	
	
	
});