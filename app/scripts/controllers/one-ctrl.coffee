###
**
 * example controller that uses a service to communicate with a REST
 * web service
 *
###

app = angular.module "app"
app.controller "MyCtrl1", ($scope, User)->

  # get all users
  users = User.query ()->
    $scope.users = users

  $scope.saveAll = ()->
    $scope.users.forEach (user)->
      user.$update()

###
  # here are some other things you can do with resources

  # here's how to fetch a resource from the server
  user = User.get {"id": 2}, ()->
    # here's how to update a resource
    user.$update ()->
      # whatever is sent back by server is automatically set by angular
      console.log "user.awesome", user.awesome  # thanks server!

    # here's how to delete a resource from the server
    user.$delete()

  # here's how to create a new resource
  user2 = new User()
  user2.neat = true
  user2.$save()

###