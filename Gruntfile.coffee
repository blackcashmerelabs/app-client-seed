module.exports = (grunt) ->

  ###############################################################
  # constants
  ###############################################################

  ENV_ID                   = grunt.option("env_id") || "develop"

  APP_DIR                  = "app"
  TEST_DIR                 = "test"
  VENDOR_DIR               = "vendor"

  APP_IMG_DIR              = "#{APP_DIR}/img"
  APP_STYLES_DIR           = "#{APP_DIR}/styles"
  APP_SCRIPTS_DIR          = "#{APP_DIR}/scripts"
  APP_VIEWS_DIR            = "#{APP_DIR}/views"
  APP_ENVS_DIR             = "#{APP_DIR}/envs"
  CURRENT_ENV_DIR          = "#{APP_ENVS_DIR}/#{ENV_ID}"

  BUILD_DIR                = "build"
  BUILD_DIST_DIR           = "#{BUILD_DIR}/dist"

  # all script, style, img nested under static root..
  BUILD_DIST_STATIC_DIR    = "#{BUILD_DIST_DIR}/static"

  # html files as jinja templates..
  BUILD_DIST_VIEWS_DIR     = "#{BUILD_DIST_DIR}/templates"
  BUILD_TEST_DIR           = "#{BUILD_DIR}/test"
  BUILD_WORKING_DIR        = "#{BUILD_DIR}/working"

  NODEAPP_DIR              = "nodeapp"
  NODEAPP_BUILD_DIR        = "#{BUILD_DIR}/nodeapp"


  ###############################################################
  # config
  ###############################################################

  grunt.initConfig

    # delete the previous build and working directories
    clean:
      dist:                BUILD_DIST_DIR
      working:             BUILD_WORKING_DIR
      build:               ["#{BUILD_WORKING_DIR}/**/*.{coffee,styl}",
                            "#{BUILD_DIST_DIR}/app.coffee"]
      default:             BUILD_DIR


    copy:
      # single page app views..
      app_views:
        files: [
          {
            expand:        true
            cwd:           APP_DIR
            src:           "**/*.html"
            dest:          BUILD_WORKING_DIR
          }
        ]
      app_scripts:
        files: [
          {
            # copy environ specific overrides..
            expand:        true
            cwd:           CURRENT_ENV_DIR
            src:           "**"
            dest:          BUILD_WORKING_DIR
          }
          {
            expand:        true
            cwd:           APP_SCRIPTS_DIR
            src:           "**"
            dest:          BUILD_WORKING_DIR
          }
        ]
      app_styles:
        files: [
          {
            expand:        true
            cwd:           APP_STYLES_DIR
            src:           "**"
            dest:          BUILD_WORKING_DIR
          }
        ]
      app_img:
        src:               ["#{APP_IMG_DIR}/**"]
        dest:              "#{BUILD_DIST_DIR}/img"


    # stylus css
    stylus:
      compile:
        src: "#{APP_STYLES_DIR}/app.styl"
        dest: "#{BUILD_WORKING_DIR}/app.css"

    coffee:
      app:
        src: "#{BUILD_WORKING_DIR}/**/*.coffee"
        dest: "#{BUILD_WORKING_DIR}/app.js"
      test:
        src: "#{TEST_DIR}/#{APP_DIR}/**/*.coffee"
        dest: "#{BUILD_TEST_DIR}/#{APP_DIR}/tests.js"
      nodeapp:
        src: "#{NODEAPP_DIR}/**/*.coffee"
        dest: "#{NODEAPP_BUILD_DIR}/app.js"


    concat:
      vendor_scripts:
        src: [
          "#{VENDOR_DIR}/**/angular/angular.js",
          "#{VENDOR_DIR}/**/angular/angular-resource.js"
        ]
        dest: "#{BUILD_DIST_DIR}/vendor.js"

      app_scripts:
        # all our angular components, including views..
        src: ["#{BUILD_WORKING_DIR}/**/*.js"]
        dest: "#{BUILD_DIST_DIR}/app.js"

      vendor_styles:
        src: ["#{VENDOR_DIR}/**/*.css"]
        dest: "#{BUILD_DIST_DIR}/vendor.css"

      app_styles:
        src: ["#{BUILD_WORKING_DIR}/**/*.css"]
        dest: "#{BUILD_DIST_DIR}/app.css"


    # inline all angular views as strings into a js file that can be
    # concatted in the package
    ngtemplates:
      options:
        base: "#{APP_DIR}"
      app:
        src:  ["#{APP_VIEWS_DIR}/**/*.html"]
        dest: "#{BUILD_WORKING_DIR}/ngviews.js"

    # convert our Angular files that use simple injects to their build-safe
    # versions
    ngmin:
      app:
        expand: true
        cwd:  "#{BUILD_WORKING_DIR}"
        src:  ["**/*.js", "!vendor/**"]
        dest: "#{BUILD_WORKING_DIR}"


    jshint:
      build_dist:
        src: ["#{BUILD_DIST_DIR}/app.js"]


    # replace all the script tags in the HTML file with the single
    # built script
    htmlrefs:
      options:
        file:
          # todo: generate unique from contents of file for each file..
          buildNumber: 47878
      build:
        src:  ["#{BUILD_WORKING_DIR}/*.html"]
        dest: "#{BUILD_DIST_DIR}/"

    # minify html files
    htmlmin:
      index:
        options:
          removeComments: true
          collapseWhitespace: true
        files:
          "build/dist/index.html": "#{BUILD_DIST_DIR}/index.html"
          "build/dist/login.html": "#{BUILD_DIST_DIR}/login.html"

    # minify the js file to be as small as possible
    uglify:
      app_scripts:
        src: ["#{BUILD_DIST_DIR}/app.js"]
        dest: "#{BUILD_DIST_DIR}/app.js"

    cssmin:
      lib_css:
        src: "#{BUILD_DIST_DIR}/vendor.css"
        dest: "#{BUILD_DIST_DIR}/vendor.css"
      app_css:
        src: "#{BUILD_DIST_DIR}/app.css"
        dest: "#{BUILD_DIST_DIR}/app.css"


    # for tests that run in browsers
    karma:
      # start karma server
      # (the watch task will run the tests when files change)
      unit:
        configFile: "config/karma.conf.js"

      # continuous integration mode for the package:
      # run tests once in PhantomJS browser.
      continuous:
        configFile: "config/karma.conf.js"
        singleRun: true
        browsers: ["PhantomJS"]

    # for tests that run in Node
    simplemocha:
      options:
        require: "should"
        timeout: 3000
        ignoreLeaks: false
        ui: "bdd"
        reporter: "dot"
      all:
        src: "#{BUILD_TEST_DIR}/nodeapp/**/*.js"

    connect:
      server:
        options:
          base: NODEAPP_BUILD_DIR


    # watches for changes in file to fire tasks
    watch:
      gruntfile:
        files: 'Gruntfile.js'
        tasks: ['jshint:gruntfile']

      scripts:
        files: ["#{APP_SCRIPTS_DIR}/**/*.coffee"]
        tasks: ['clear', 'karma:unit:run']
        options:
          livereload: 3000

      styles:
        files: ["#{APP_STYLES_DIR}/**/*.styl"]
        tasks: ['clear', 'stylus']
        options:
          livereload: 3000

      views:
        files: ["#{APP_VIEWS_DIR}/**/*.html"]
        tasks: ['clear', 'karma:unit:run']
        options:
          livereload: 3000

      tests:
        files: ["#{TEST_DIR}/app/**/*.js"]
        tasks: ['clear', 'karma:unit:run']
        options:
          livereload: 3000


  ###############################################################
  # grunt plugins
  ###############################################################

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-htmlmin'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-angular-templates'
  grunt.loadNpmTasks 'grunt-clear'
  grunt.loadNpmTasks 'grunt-htmlrefs'
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-ngmin'


  ###############################################################
  # alias tasks
  ###############################################################

  grunt.registerTask 'test', ['karma:continuous']

  ###
   * build task explanation
   * 1. delete the existing "BUILD_WORKING_DIR".
   * 2. compile stylus into CSS.
   * 3. copy images into the BUILD_DIR.
   * 4. generate a JS file containing all our Angular templates.
   * 5. generate build-safe versions of our Angular controllers, services, directives, filters, etc.
   * 6. combine all our scripts, including generated versions, into a single JS file. Also combine all CSS into one file.
   * 7. compress the single JS file.
   * 8. replace all our <script> tags in our index.html file with a single <script> tag pointing to the combined/compressed JS file.
   * 9. compress the index.html file.
   * 10. delete the BUILD_DIR
  ###
  grunt.registerTask "build", [
    # clear previous build package
    "clean:dist",
    "copy", "stylus", "coffee", "ngtemplates", "ngmin",
    # "jshint",
    "clean:build",
  ]

  grunt.registerTask "build_casperjs", [
  ]

  grunt.registerTask "dist", [
    "build", "concat", "uglify", "cssmin", "htmlrefs", "htmlmin",
    # clear built compilation dir
    "clean:working",
  ]
