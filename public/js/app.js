$(document).ready(function(){
	
	var loadingImage = $('<img src="/images/countdown.gif" alt="loading..." class="loading-image"/>');
	
	$('form').on('submit', function(e){
		e.preventDefault();
		$.ajax({
			type: this.method,
			url: this.action,
			data: $(this).serialize(),
			beforeSend: function(){
				$('section#main').html(loadingImage);
			},
			success: function(data){
				$('section#main').html(data);
			}
		});
	});
	
	$(document).on('click', 'a.copy', function(e){
		e.preventDefault();
		$('#text-to-copy').select();
		$('#copy-instructions').fadeIn(500).delay(2500).fadeOut(500);
	});
	
});