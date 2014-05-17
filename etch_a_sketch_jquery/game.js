var n = 20;
var boardsize = 640;
var gameType = 1;

// Game types:
// 1: Normal
// 2: Gradient
// 3: Random color
// 4: Fading trail 

$(document).ready( function() {
	buildBoard(n);

	$(document).on('mouseenter','.square', function() {
		changeColor(this);
	});

	$("#clear").click( function() {
		clearBoard();
	});

	$("#set_size").click( function() {
		var num = prompt("Enter a number between 1 and 64");
		if (num == parseInt(num) && num > 0 && num < 65){
			buildBoard(num);
			n = num;
		}

	});

	$("input[name=game-type]").change( function() {
		changeGameType(this);
		});

	$(document).on('mouseout','.square', function() {
		//If fading trail gameType, fade the square back to red
		if ( gameType == 4)
			$(this).fadeTo(800,1);
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

function changeColor(element) {
	switch (gameType) {
		case 1:
			//Normal
			$(element).css('background-color','black');
		break;
		case 2:
			//Gradient
			var op = $(element).css("opacity");
			$(element).css("opacity", (op > 0.15) ? (op - 0.15) : 0);
			break;
		case 3:
			//Random color
			var randColor = getRandomColor();
			$(element).css('background-color',randColor);
		break;
		case 4:
			//Fading trail
			$(element).css("opacity", 0);

		break;
	}
}

function computeDimensions(n){
	return boardsize/n - 2; //-2 for borders
}

function clearBoard() {
	$('.square').css('background-color','red');
}

function changeGameType(element) {
	gameType = parseInt($(element).attr('id'));
	buildBoard(n);
}

function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}