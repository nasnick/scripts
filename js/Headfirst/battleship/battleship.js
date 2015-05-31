
var view = {
	displayMesssge: function(msg) {
		var messageArea = document.getElementById("messageArea");
		messageArea.innerHTML = msg;
	},
	displayHit: function(location){
		var cell = document.getElementById(location);
		cell.setAttribute("class", "hit"); 
	},
	displayMiss: function(location){
		var cell = document.getElementById(location);
		cell.setAttribute("class", "miss");
	}
};
// var a = 0;
// var b = 1;
// view.displayHit('0' + 0);
// view.displayMiss(11);
// view.displayMesssge("Is this thing switched on?");

var model = {
	boardSize: 7,
	numShips: 3,
	shipsSunk: 0,
	shipLength: 3,
	ships: [{ locations: ["06", "16", "26"], hits: ["", "", ""] },
			  { locations: ["24", "34", "44"], hits: ["", "", ""] }, 
		     { locations: ["10", "11", "12"], hits: ["", "", ""] }],
	fire: function(guess) {
	for (var i = 0; i < this.numShips; i++) { 
		var ship = this.ships[i];
		var index = ship.locations.indexOf(guess);
		if (index >= 0){
			ship.hits[index] === "hit";
				view.displayHit(guess);
				view.displayMesssge("HIT!");
			if (this.isSunk(ship)) {
				view.displayMesssge("You sank my battleshit!");
				this.shipsSunk++;
		     }
			  return true;
			}
		}
		view.displayMiss(guess);
		view.displayMesssge("MISS!");
		return false;
	},
	isSunk: function(ship){
		for (var i = 0; i < this.shipLength; i++){
			if (ship.hits[i] !== "hit"){
				return false;
			}
		}
		return true;
	}
};

var controller = { 
	guesses: 0,
	processGuess: function(guess) {
		var location = parseGuess(guess);
		if(location){
			this.guesses++;
			var hit = model.fire(location);
			if (hit && model.shipsSunk === model.numShips) {
			view.displayMesssge("Ahoy! You sank all the batteshits in " + this.guesses + " guesses");
		 }
	} 
}
};

function parseGuess(guess) {
	var alphabet = ["A", "B", "c", "D", "E", "F", "G"];
	if(guess === null || guess.length !== 2){
		alert("oopsie daysies!");
	} else {
		firstChar = guess.charAt(0);
		row = alphabet.indexOf(firstChar);
		column = guess.charAt(1);
		console.log(firstChar);
		console.log(row);
		console.log(column);
		if(isNaN(row) || isNaN(column)) {
			alert("Oops! No good la!");
		} else if (row < 0 || row >= model.boardSize ||  column < 0 || column >= model.boardSize) {
			alert("OOOooh number no good too big or too small!");
		} else {
			alert("yoooo goood lah!");
			return row + column;
		}
			
		}
		return null;
};

function init(){
  var fireButton = document.getElementById("fireButton");
  fireButton.onClick = handleFireButton;
}

function handleFireButton(){
	var guessInput = document.getElementById("guessInput");
	var guess = guessInput.value;
	controller.processGuess(guess);
	guessInput.value = "";
}
window.onload = init;

// controller.processGuess("A0");
// controller.processGuess("A6"); 
// controller.processGuess("B6"); 
// controller.processGuess("C6");
// controller.processGuess("C4"); 
// controller.processGuess("D4"); 
// controller.processGuess("E4");
// controller.processGuess("B0"); 
// controller.processGuess("B1"); 
// controller.processGuess("B2");
