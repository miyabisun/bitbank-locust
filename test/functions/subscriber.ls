require! {
  chai: {expect}
  \../../functions/subscriber.ls : main
}
key = \sub-c-e12e9174-dd60-11e6-806b-02ee2ddab7fe

file = "test#{__filename - /^.*test/}"
describe file, ->
  s = subscriber: null
  before ->
    s.subscriber = main \depth_btc_jpy, key
  after ->
    s.subscriber.stop!
  describe \type, ->
    specify "is function", ->
      expect main .to.be.an \function
    specify "result is object", ->
      expect s.subscriber .to.be.a \object
  describe "successful", ->
    specify \on, ->>
      new Promise (resolve) ->
        fn = ->
          expect it .to.be.a \object
          resolve it
        s.subscriber.on fn
    specify \has, ->
      console.log
      s.subscriber.on (fn = ->)
      expect s.subscriber.has fn .to.be.true
    specify "off", ->
      s.subscriber.on (fn = ->)
      s.subscriber.off fn
      s.subscriber.has fn |> expect >> (.to.be.false)
