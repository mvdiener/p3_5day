$(document).ready(function(){

	$('#flight_api_form').on('submit', function(event){
		event.preventDefault();

		var data = $(this).serialize();

		$.ajax({
			type: "POST",
			url: '/flight_api',
			data: data,
			success: function(data){
				$('#post-form').append(data);
				$('#query-form').text('')
			}
		});
	});
});
