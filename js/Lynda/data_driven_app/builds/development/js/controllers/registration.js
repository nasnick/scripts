//get Authentication from authentication factory
myApp.controller('RegistrationController', 
	function($scope, $firebaseAuth, $location, Authentication) {

		// var ref = new Firebase(FIREBASE_URL);
		// var auth = $firebaseAuth(ref);

	$scope.login = function() {
		// auth.$authWithPassword({
			//'user' below coming in from view
			Authentication.login($scope.user)
		.then(function(user) {
			$location.path('/meetings');
		}).catch(function(error) {
			$scope.message = error.message;
		});
	}; //login

		$scope.register = function() {
		//apends /meetings to the URL
		Authentication.register($scope.user)
		.then(function(user) {
			Authentication.login($scope.user);
			$location.path('/meetings');
			}).catch(function(error) {
			$scope.message = error.message;
			})
	}; //register
}); //RegistrationController


// ng-submit example => https://docs.angularjs.org/api/ng/directive/ngSubmit