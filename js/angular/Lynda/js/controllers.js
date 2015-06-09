var myApp = angular.module('myApp', []);

myApp.controller('MyController', function MyController($scope) {
//create an object
$scope.author = {
	'name':'Rocku Roo',
   'title':'Lover Not Fighter',
 'company':'Nakano Knights'
  }
});