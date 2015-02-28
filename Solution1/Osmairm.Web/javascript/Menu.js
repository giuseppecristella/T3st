
function headerMenuController($scope, $location) {

    $scope.getClass = function (path) {
        
        if ($location.absUrl().indexOf(path) > 1) {
            return "current";
        } else {
            return "";
        }
    }
}

