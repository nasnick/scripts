//appControllers to be defined below. myApp in array refers to myApp in html document.
var myApp = angular.module('myApp', ['ngRoute', 'firebase', 'appControllers'])
.constant('FIREBASE_URL', 'https://attendanceapproger.firebaseio.com/');

var appControllers = angular.module('appControllers', ['firebase']);

myApp.run(['$rootScope', '$location', function($rootScope, $location) {
	$rootScope.$on('$routeChangeError',
		function(event, next, previous, error) {
			if(error === 'AUTH_REQUIRED') {
				$rootScope.message="Sorry, you need to be authenticated to see this page";
				$location.path('/login');

		}
	});
}]);

myApp.config(['$routeProvider', function($routeProvider) {
	$routeProvider.
	when('/login', {
		templateUrl: 'views/login.html',
		controller: 'RegistrationController'
	}).
	when('/register', {
		templateUrl: 'views/register.html',
		controller: 'RegistrationController'
	}).
	when('/meetings', {
		templateUrl: 'views/meetings.html',
		controller: 'MeetingsController',
		resolve : { 
			currentAuth: function(Authentication) {
				return Authentication.requireAuth();
			}

		}
	}).
	otherwise({
		redirectTo: '/login'
	});
}]);