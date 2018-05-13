require! {
  chai: {expect}
  \../../classes/offer.ls : Klass
  \../data/depth.json
}
data = depth.asks.0

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Klass .to.be.an \function
    specify "return is instance", ->
      expect Klass.from data .to.be.an.instanceof Klass
  describe \instance, ->
    i = Klass.from data
    <[price amount]>.for-each (key) ->
      specify "#key key is number", ->
        expect i.(key) .to.be.a \number
