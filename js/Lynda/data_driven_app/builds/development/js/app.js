//appControllers to be defined below. myApp in array refers to myApp in html document.
var myApp = angular.module('myApp', ['ngRoute', 'firebase', 'appControllers']);

var appControllers = angular.module('appControllers', ['firebase']);

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
		controller: 'MeetingsController'
	}).
	otherwise({
		redirectTo: '/login'
	});
}]);