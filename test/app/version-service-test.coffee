
describe "version service", ()->
  beforeEach module("app")
  it "should return current version", inject (version)->
    expect(version).to.equal "0.2.0"
