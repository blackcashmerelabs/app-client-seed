###
**
 * example directive
 *
###

app = angular.module "app"
app.directive "appVersion", (version)->
  return (scope, elem, attrs)->
    elem.text version
    console.log "attrs", attrs
