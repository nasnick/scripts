
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
var a = 0;
var b = 1;
view.displayHit('0' + 0);
view.displayMiss(11);
view.displayMesssge("Is this thing switched on?");


var ships = [{ locations: ["31", "41", "51"], hits: ["", "", ""] },
				 { locations: ["14", "24", "34"], hits: ["", "hit", ""] }, 
   			 { locations: ["00", "01", "02"], hits: ["hit", "", ""] }];
				 
//Finish this code to access the second ship's middle location and print its value with console.log.
				 
var ship2 = ships[1];
var locations = ship2.locations; 
console.log("Location is " + locations[1]);

//Finish this code to see if the third ship has a hit in its first location:

var ship3 = ships[2]; 
var hits = ship3.hits[0]; 
	if (hits === "hit") {
			console.log("Ouch, hit on third ship at location one"); 
	}
	
//Finish this code to hit the first ship at the third location:

var ship1= ships[0]; 
var hits = ship1.hits; 
hits[2] = "hit";
hits[0] = "hit";
console.log(ship1.hits);
