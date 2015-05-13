
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