myApp.controller('RegistrationController', 
	function($scope, $location) {
	$scope.login = function() {
		//$location apends /meetings to the URL
		$location.path('/meetings');
	} //login

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