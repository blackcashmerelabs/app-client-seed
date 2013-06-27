###
**
 * example controller that has dependencies to be injected
 *
###

app = angular.module "app"
app.controller "MyCtrl2", ($scope, version)->
  $scope.people = ["Jim", "Jimmies", "Jummy"]

  # has a dependency on our version service, which we will mock out
  # when testing this controller
  $scope.version = version + "!"

  # computed property
  $scope.longestName = ()->
    return $scope.people.reduce (prev, curr)->
      # todo: coffee tenary
      return prev.length > curr.length ? prev : curr
