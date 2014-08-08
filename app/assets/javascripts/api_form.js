$(document).ready(function(){

	$('#flight_api_form').on('submit', function(event){
		event.preventDefault();

		var data = $(this).serialize();

		$.ajax({
			type: "POST",
			url: '/flight_api',
			data: data,
			dataType: 'json',
			success: function(data){
				for(i = 0; i < data.length; i++)
				$('#flight_api_form').after("<p>" + data + "</p>");
			}
		});
	});
});
