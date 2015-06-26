myApp.factory('Authentication', function($firebase, $firebaseAuth, 
	$routeParams, $location, FIREBASE_URL) {

 var ref = new Firebase(FIREBASE_URL);
 var auth = $firebaseAuth(ref);

//Temporary object
var myObject = {

	//$scope passed along with 'user' from registration controller so not needed here
	// user object passed to $authWithPassword method (from $firebaseAuth)
	login: function(user) {
		return auth.$authWithPassword({
			email: user.email,
			password: user.password
		}); //$authWithPassword
	  }, //login

	register: function(user) {
		return auth.$createUser({
			email: user.email,
			password: user.password
		}).then(function(regUser){
			
		}); //$authWithPassword
	  }, //register

	}; //myObject
return myObject;
});