var n = 20;
var boardsize = 840;


$(document).ready( function() {
	buildBoard(n);

	$(document).on('mouseenter','.square', function() {
		$(this).css('background-color','black');
	});

	$("#clear").click( function() {
		$('.square').css('background-color','red');
	});

	$("#set_size").click( function() {
		var num = prompt("Enter a number between 1 and 64");
		if (num == parseInt(num) && num > 0 && num < 65){
			buildBoard(num);
			n = num;
		}

	});

});

function buildBoard(n){
	$("#wrapper").empty();
	for(j = 0; j < n; j++){
		for(i = 0; i< n; i++) {
			$('#wrapper').append("<div class='square'></div>");
		}
		$('#wrapper').append('<div class="clearfix"></div>');
	}
	var squareWidth = computeDimensions(n);
	$('.square').css('height', squareWidth);
	$('.square').css('width', squareWidth);
}

function changeColor() {
	$(this).css('background-color','black');
}

function computeDimensions(n){
	return boardsize/n - 2; //-2 for borders
}

$("#clear").click( function() {
	// $('#wrapper').empty();
	$('.square').css('background-color','red');
	// buildBoard(n);
});


function clearBoard() {
	$('.square').css('background-color','red');
}