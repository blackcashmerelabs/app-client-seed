describe "MyCtrl2", ()->
  beforeEach module("app")
  beforeEach inject(($rootScope, $controller)->
    scope = $rootScope.$new()
    ctrl = $controller "MyCtrl2", {$scope: scope, version: "9.9.9"}
  )

  it "should be injected correctly", ()->
    expect(ctrl).not.to.be undefined
    expect(scope.people.length).to.be 3

  describe "longestName computed property", ()->
    it "should return the longest name", ()->
      expect(scope.longestName()).to.be "Jimmies"
      scope.people.push "Jimmyjim"
      expect(scope.longestName()).to.be "Jimmyjim"

  describe "mocking a depdendency", ()->
    # super useful for writing good, isolated tests
    it "should let us pass in whatever we want", ()->
      # notice how we are testing the behavior of our controller on its
      # dependencies, not anything specific of the dependencies themselves
      # awesome.
      expect(scope.version).to.equal "9.9.9!"
