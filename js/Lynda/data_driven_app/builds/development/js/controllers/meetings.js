myApp.controller('MeetingsController',
	function($scope, $firebase) {
		var ref = new Firebase("https://attendanceapproger.firebaseio.com/meetings");
		var meetings = $firebase(ref);
		$scope.meetings = meetings.$asObject();
		//addMeeting below is from ng-submit="addMeeting()" in meetings.html
		
		$scope.addMeeting = function() {
			//pushing an object into method $push
			meetings.$push({
				name: $scope.meetingname,
				date: Firebase.ServerValue.TIMESTAMP
				//A promise - once data has been pushed then field will become empty
			}).then(function() {
				$scope.meetingname='';
			});
		}; //add meeting
		
		$scope.deleteMeeting = function(key){
			meetings.$remove(key);
		};


});




