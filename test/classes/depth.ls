require! {
  chai: {expect}
  \../../classes/depth.ls : Klass
  \../../classes/offer.ls : Offer
  \../data/depth.json : data
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Klass .to.be.an \function
    specify "return is instance", ->
      expect Klass.from data .to.be.an.instanceof Klass
  describe \properties, ->
    i = Klass.from data
    <[asks bids]>.for-each (key) ->
      specify "#key key is array", ->
        expect i.(key) .to.be.an \array
      specify "#key items is Offer instance", ->
        i.(key).for-each expect >> (.to.be.an.instanceof Offer)
  describe \methods, ->
    i = Klass.from data
    <[askOf bidOf]>.for-each (key) ->
      specify "#key is function", ->
        expect i.(key) .to.be.a \function
      specify "#key(1) is Offer instance", ->
        i.(key) 1 |> expect >> (.to.be.an.instanceof Offer)
    describe "update successful", ->
      instance = Klass.from data
      instance.update {} <<< data <<< asks: [], bids: []
      <[asks bids]>.for-each (name) ->
        specify "#name is empty array", ->
          expect instance.(name) .to.be.an \array .that.be.empty
