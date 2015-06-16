// first declare a module called artistController
// The same as in the Headfirst book:
// function serveCustomer(passenger) { 
//   var getDrinkOrderFunction = createDrinkOrder(passenger);
// artistController is a call to angular.module and all its goodness passing in artistController. 
// artistController is then called with .controller. So artistController is a module and then
// defines a controller called ListController.
// In app.js, myApp is defined as a module and takes artistController as a parameter along with
// ng-route. So myApp would be at the top of the tree.


var artistController = angular.module('artistController', []);

//An instance of the module defined above?
artistController.controller('ListController',['$scope', '$http', function($scope, $http) {

$http.get('js/data.json').success(function(data) {
  $scope.artists = data;
  $scope.artistOrder = 'name';
  });
}]);

artistController.controller('DetailsController',['$scope', '$http','$routeParams', function($scope,
$http, $routeParams) {

$http.get('js/data.json').success(function(data) {
  $scope.artists = data;
  $scope.whichItem = $routeParams.itemId;
  if($routeParams.itemId > 0) {
  		$scope.prevItem = Number($routeParams.itemId)-1;
  } else {
  		$scope.prevItem = $scope.artists.length-1;

  };

    if($routeParams.itemId < $scope.artists.length-1) {
    	$scope.nextItem = Number($routeParams.itemId)+1;
  } else {
  		$scope.nextItem = 0;

  };
  });
}]);
