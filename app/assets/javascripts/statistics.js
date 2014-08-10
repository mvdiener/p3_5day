function parseData(){
	return JSON.parse($("#hidden_flights").text());
};


var dataset;

//Define bar chart function 
	function barChart(dataset){	

		//Set width and height as fixed variables
		var w = 520;
		var h = 500;
		var padding = 30;

		//Scale function for axes and radius
		var yScale = d3.scale.linear()
						.domain(d3.extent(dataset, function(d){return d.arrivalDifference;}))
						.range([w+padding,padding]);

		var xScale = d3.scale.ordinal()
						.domain(dataset.map(function(d){ return d.flight;}))
						.rangeRoundBands([padding,h+padding],.3);

		//To format axis as a percent
		var formatAxis = d3.format("d");

		//To add proper text to hover box
		var formatTime = function(time){
			if (time < 0) {
				return "Late by " + Math.abs(time) + " mins";
			} else if (time > 0) {
				return "Early by " + time + " mins";
			}
		}

		//Create y axis
		var yAxis = d3.svg.axis().scale(yScale).orient("left").ticks(5).tickFormat(formatAxis);

		//Define key function
		var key = function(d){return d.flight};

		//Define tooltip for hover-over info windows
		var div = d3.select("body").append("div")   
  							.attr("class", "bar-hover")               
  							.style("opacity", 0);

		//Create svg element
		var svg = d3.select("#chart-container").append("svg")
				.attr("width", w).attr("height", h)
				.attr("id", "chart")
				.attr("viewBox", "0 0 "+w+ " "+h)
				.attr("preserveAspectRatio", "xMinYMin");
		
		//Resizing function to maintain aspect ratio (uses jquery)
		var aspect = w / h;
		var chart = $("#chart");
			$(window).on("resize", function() {
			    var targetWidth = $("body").width();
			   	
	    		if(targetWidth<w){
	    			chart.attr("width", targetWidth); 
	    			chart.attr("height", targetWidth / aspect); 			
	    		}
	    		else{
	    			chart.attr("width", w);  
	    			chart.attr("height", w / aspect);	
	    		}

			});


		//Initialize state of chart according to drop down menu
		var state = d3.selectAll("option");

		//Create barchart
		svg.selectAll("rect")
			.data(dataset, key)
			.enter()
		  	.append("rect")
		    .attr("class", function(d){return d.arrivalDifference < 0 ? "negative" : "positive";})
		    .attr({
		    	x: function(d){
		    		return xScale(d.flight);
		    	},
		    	y: function(d){
		    		return yScale(Math.max(0, d.arrivalDifference)); 
		    	},
		    	width: xScale.rangeBand(),
		    	height: function(d){
		    		return Math.abs(yScale(d.arrivalDifference) - yScale(0)); 
		    	}
		    })
		    .on('mouseover', function(d){
							d3.select(this)
							    .style("opacity", 0.2)
							    .style("stroke", "black")
					
					var info = div
							    .style("opacity", 1)
							    .style("left", (d3.event.pageX+10) + "px")
							    .style("top", (d3.event.pageY-30) + "px")
							    .text("Flight " + d.flight_number);

					if(state[0][0].selected){						
						info.append("li")
							    .text("Arrived " + d.arrivalActual);
						info.append("li")
							    .text(formatTime(d.arrivalDifference));

					}
					else if(state[0][1].selected){
						info.append("li")
							    .text("Departed " + d.departureActual);
						info.append("li")
							    .text(formatTime(d.departureDifference));
					}



						})
        				.on('mouseout', function(d){
        					d3.select(this)
							.style({'stroke-opacity':0.5,'stroke':'#a8a8a8'})
							.style("opacity",1);

							div
	    						.style("opacity", 0);
        				});

		//Add y-axis
		svg.append("g")
				.attr("class", "y axis")
				.attr("transform", "translate(40,0)")
				.call(yAxis);

		//Sort data when sort is checkedf
		d3.selectAll(".checkbox").
		on("change", function(){
			var x0 = xScale.domain(dataset.sort(sortChoice())
			.map(function(d){return d.flight}))
			.copy();

			var transition = svg.transition().duration(750);
			var delay = function(d, i){return i*10;};

			transition.selectAll("rect")
			.delay(delay)
			.attr("x", function(d){return x0(d.flight);});

		})

		//Function to sort data when sort box is checked
		function sortChoice(){
				var state = d3.selectAll("option");
				var sort = d3.selectAll(".checkbox");

				if(sort[0][0].checked && state[0][0].selected){
					var out = function(a,b){return b.arrivalDifference - a.arrivalDifference;}
					return out;
				}
				else if(sort[0][0].checked && state[0][1].selected){
					var out = function(a,b){return b.departureDifference - a.departureDifference;}
					return out;
				}
				else{
					var out = function(a,b){return d3.ascending(a.flight, b.flight);}
					return out;
				}
		};

		//Change data to correct values on input change
			d3.selectAll("select").
			on("change", function() {
			
				var value= this.value;

				if(value=="departure"){
					var x_value = function(d){return d.departureDifference;};
					var color = function(d){return d.departureDifference < 0 ? "negative" : "positive";};
					var y_value = function(d){
			    		return yScale(Math.max(0, d.departureDifference)); 
			    	};
			    	var height_value = function(d){
			    		return Math.abs(yScale(d.departureDifference) - yScale(0));
			    	};	
				}
				else if(value=="arrival"){
					var x_value = function(d){return d.arrivalDifference;};
					var color = function(d){return d.arrivalDifference < 0 ? "negative" : "positive";};
					var y_value = function(d){
			    		return yScale(Math.max(0, d.arrivalDifference)); 
			    	};
			    	var height_value = function(d){
			    		return Math.abs(yScale(d.arrivalDifference) - yScale(0)); 
			    	};	
				}

				//Update y scale
				yScale.domain(d3.extent(dataset, x_value));

				//Update with correct data
				var rect = svg.selectAll("rect").data(dataset, key);
				rect.exit().remove();

				//Transition chart to new data
				rect
				.transition()
				.duration(2000)
				.ease("linear")
				.each("start", function(){
					d3.select(this)
					.attr("width", "0.2")
					.attr("class", color)
				})
				.attr({
			    	x: function(d){
			    		return xScale(d.flight);
			    	},
			    	y: y_value,
			    	width: xScale.rangeBand(),
			    	height: height_value
							
				});

				//Update y-axis
				svg.select(".y.axis")
					.transition()
					.duration(1000)
					.ease("linear")
					.call(yAxis);
			});
		
	};
 
var flightData = parseData();

	//Load data and call bar chart function 
		// d3.csv("javascripts/transportation_change_2012-2013_small.csv", function(error,data){
		// 		if(error){
		// 			console.log(error);
		// 		}
		// 		else{
						flightData.forEach(function(d) {
							d.arrivalDifference = parseFloat(d.arrivalDifference);
							d.departureDifference = parseFloat(d.departureDifference);
						});
						dataset=flightData;
						barChart(dataset);
			// 	}
			// });
