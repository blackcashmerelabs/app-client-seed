
# describe "since we are running in the browser", ()->
#   it "also has access to the DOM", ()->
#     expect(window).not.to.be undefined
#     expect(angular).not.to.be undefined

describe "app-version", ()->
  # beforeEach(module("app"))

  it "should print current version", ()->

    # inject ($provide)->
    #   $provide.value "version", "TEST_VER"

    # module ($provide)->
    #   $provide.value "version", "TEST_VER"

    # inject ($compile, $rootScope)->
    #   element = $compile("<span app-version></span>")($rootScope)
    #   expect(element.text()).toEqual "TEST_VER"
