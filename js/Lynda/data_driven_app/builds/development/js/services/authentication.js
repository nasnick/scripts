myApp.factory('Authentication', function($firebase, $firebaseAuth, 
	$routeParams, $rootScope, $location, FIREBASE_URL) {

	//$rootScope is global variable available in entire app

 var ref = new Firebase(FIREBASE_URL);
 var auth = $firebaseAuth(ref);

 auth.$onAuth(function(authUser){
 	if (authUser) {
 		var ref = new Firebase(FIREBASE_URL + '/users/' + authUser.uid);
 		var user = $firebase(ref).$asObject();
 		$rootScope.currentUser = user;
 	} else {
 		$rootScope.currentUser = '';
 	}
 });

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

	  logout: function(user){
	  	//$unauth is a firebase service
	  	return auth.$unauth();
	  },

	register: function(user) {
		return auth.$createUser({
			email: user.email,
			password: user.password
		}).then(function(regUser) {
			var ref = new Firebase(FIREBASE_URL+'users');
			var firebaseUsers = $firebase(ref);

			var userInfo = {
				date		: Firebase.ServerValue.TIMESTAMP,
				regUser		: regUser.uid,
				firstname	: user.firstname,
				lastname	: user.lastname,
				email		: user.email
			}; //user info
			firebaseUsers.$set(regUser.uid, userInfo);
		}); //promise
	  }, //register

	  requireAuth: function(){
	  	return auth.$requireAuth();
	  },
	  	  waitForAuth: function(){
	  	return auth.$waitForAuth();
	  }//wait until user in authenticated

	}; //myObject
return myObject;
});