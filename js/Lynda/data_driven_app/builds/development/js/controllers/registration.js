//get Authentication from authentication factory
myApp.controller('RegistrationController', 
	function($scope, $firebaseAuth, $location, Authentication) {

		var ref = new Firebase("https://attendanceapproger.firebaseio.com");
		var auth = $firebaseAuth(ref);

	$scope.login = function() {
		//$send in an object to the $authWithPassword function
		// auth.$authWithPassword({
			//user below coming in from view
			Authentication.login($scope.user)
		}).then(function(user) {
			$location.path('/meetings');
		}).catch(function(error) {
			$scope.message = error.message;
		});
	}; //login

		$scope.register = function() {
		//apends /meetings to the URL
		$location.path('/meetings');
	} //register

}); //RegistrationController


// ng-submit example => https://docs.angularjs.org/api/ng/directive/ngSubmit