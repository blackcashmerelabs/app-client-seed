###
**
 * user service
 *
###

app = angular.module "app"
app.factory "User", ($resource)->
  return $resource "user/:id", {id: "@id"}, {
    # angular does a POST by default for create and update
    # this adds an $update method that will do a PUT
    update:
      method: "PUT"
  }
