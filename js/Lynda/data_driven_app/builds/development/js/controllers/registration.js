myApp.controller('RegistrationController', function($scope) {
		$scope.name = 'Nick';

		$scope.$on('$viewContentLoaded', function(){
			console.log($scope.myform);
		});
	});