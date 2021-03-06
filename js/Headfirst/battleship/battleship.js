var model = {
	boardSize: 7,
	numShips: 3,
	shipsSunk: 0,
	shipLength: 3,

	ships: [{ locations: ["0", "0", "0"], hits: ["", "", ""] },
			{ locations: ["0", "0", "0"], hits: ["", "", ""] }, 
		    { locations: ["0", "0", "0"], hits: ["", "", ""] }
		    ],
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
			if (ship.hits[i] !== "hit") {
				return false;
			}
		}
		return true;
	},


	generateShipLocations: function() {
		var locations;
		for(var i = 0; i < this.numShips; i++) {
			do {
				locations = this.generateShip();
			} while (this.collision(locations));
			this.ships[i].locations = locations;
		}
	},


	generateShip: function(){
		var direction = Math.floor(Math.random() * 2);
		var row, col;
		if (direction === 1) {
			row = Math.floor(Math.random() * this.boardSize);
			col = Math.floor(Math.random() *  (this.boardSize - this.shipLength + 1));
		} else {
			row = Math.floor(Math.random() * (this.boardSize - this.shipLength + 1));
			col = Math.floor(Math.random() * this.boardSize);

		} 
		var newShipLocations = [];
		for (var i = 0; i < this.shipLength; i++) {
			if (direction === 1) {
				newShipLocations.push(row + "" + (col + i));
		} else {
				newShipLocations.push((row + i) + "" + col);
			}
		}
		return newShipLocations;
	},


	collision: function(locations) {
		for (var i = 0; i < this.numShips; i++) {
			var ship = this.ships[i];
			for (var j = 0; j < locations.length; j++) {
				if (ship.locations.indexOf(locations[j]) >= 0) {
					return true;
		   }
	  	}
   	  }
	return false;
   }
};

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
}

function parseGuess (guess) {
	var alphabet = ["A", "B", "C", "D", "E", "F", "G"];
	if(guess === null || guess.length !== 2) {
		alert("oopsie daysies!");
	} else {
		var firstChar = guess.charAt(0);
		var row = alphabet.indexOf(firstChar);
		var column = guess.charAt(1);
		console.log(firstChar);
		console.log(row);
		console.log(column);
		if(isNaN(row) || isNaN(column)) {
			alert("Oops! No good la!");
		} else if (row < 0 || row >= model.boardSize ||  column < 0 || column >= model.boardSize) {
			alert("OOOooh number no good too big or too small!");
		} else {
			// alert("yoooo goood lah!");
			return row + column;
			}
			
		}
		return null;
}

function handleFireButton() {
	var guessInput = document.getElementById("guessInput");
	var guess = guessInput.value;
	controller.processGuess(guess);
	guessInput.value = "";
}

function handleKeyPress(e) {
	var fireButton = document.getElementById("fireButton");
	if (e.keyCode === 13) {
		fireButton.click();
		return false;
	}
}

window.onload = init;

function init() {
  var fireButton = document.getElementById("fireButton");
  fireButton.onclick = handleFireButton;

  var guessInput = document.getElementById("guessInput");
  guessInput.onkeypress = handleKeyPress;

  model.generateShipLocations();
}



// Loop for the number of ships we want to create.

// Generate a random direction (vertical or horizontal) for the new ship.

// Generate a random location for the new ship.

// Test to see if the new ship's locations collide with any existing ship's locations.

// Add the new ship's locations to the ships array.


