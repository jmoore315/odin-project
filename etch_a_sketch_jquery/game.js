var n = 20;
var boardsize = 840;


$(document).ready( function() {
	//$('#wrapper').width((boardsize/n) * n);
	buildBoard(n);

	$(document).on('mouseenter','.square', function() {
		$(this).css('background-color','black');
	});
});

function buildBoard(n){
	for(j = 0; j < n; j++){
		for(i = 0; i< n; i++) {
			$('#wrapper').append("<div class='square'></div>");
		}
		$('#wrapper').append('<div class="clearfix"></div>');
	}
	$('.square').css('height', computeDimensions(n));
	$('.square').css('width', computeDimensions(n));
}

function changeColor() {
	$(this).css('background-color','black');
}

function computeDimensions(n){
	return boardsize/n - 2; //-2 for borders
}

$('#clear').click( function() {
	// $('#wrapper').empty();
	$('.square').css('background-color','red');
	// buildBoard(n);
});

function clearBoard() {
	$('.square').css('background-color','red');
}