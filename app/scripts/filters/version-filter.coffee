###
**
 * example filter
 *
###

app = angular.module "app"
app.filter "interpolate", (version)->
  return (text)->
    return String(text).replace /\%VERSION\%/mg, version
