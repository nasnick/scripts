myApp.controller('RegistrationController', 
	function($scope, $firebaseAuth, $location) {

		var ref = new Firebase("https://attendanceapproger.firebaseio.com");
		var auth = $firebaseAuth(ref);

	$scope.login = function() {
		//$send in an object to the $authWithPassword function
		auth.$authWithPassword({
			email: $scope.user.email,
			password: $scope.user.password
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


//This loaded after the page finished loading and returned the 'myform' object

//function($scope) {
//  $scope.name = 'Nick';
//  $scope.$on('$viewContentLoaded', function(){
// 	  console.log($scope.myform);
// });
//});

// ng-submit example => https://docs.angularjs.org/api/ng/directive/ngSubmit