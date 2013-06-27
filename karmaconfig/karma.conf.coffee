basePath        = "../"
browsers        = ["Chrome"]
require         = "expect"
reporters       = ["dots"]
junitReporter   =
  outputFile:   "test_out/unit.xml",
  suite:        "unit"

files           = [
  MOCHA,
  MOCHA_ADAPTER,

  # vendor scripts
  "vendor/angular/angular.js",
  "vendor/angular/angular-*.js",

  # test assertion lib and mocks
  "node_modules/expect.js/expect.js",
  "test/vendor/angular/angular-mocks.js",

  # app source files
  "build/working/app.js",

  # everything else
  "build/working/**/*.js",

  # tests to run
  "build/test/app/**/*.js"
]
