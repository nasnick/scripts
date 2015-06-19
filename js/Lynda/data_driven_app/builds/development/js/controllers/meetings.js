myApp.controller('MeetingsController',
	function($scope, $firebaseObject) {

		var ref = new Firebase("https://attendanceapproger.firebaseio.com/meetings");
		$scope.meetings = $firebaseObject(ref);
		// $scope.meetings = meetings.$asObject();

});




