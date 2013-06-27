###
**
 * declare app module that has dependency on ngResource
 *
###

app = angular.module "app", ["ngResource"]
app.config ["$routeProvider", ($route_provider)->

    # setup url routes

    $route_provider.when "/view1", {
      templateUrl: "views/partial1.html"
      controller: "MyCtrl1"
    }

    $route_provider.when "/view2", {
      templateUrl: "views/partial2.html"
      controller: "MyCtrl2"
    }

    $route_provider.otherwise {
      redirectTo: "/view1"
    }

  ]
