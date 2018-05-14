require! {
  chai: {expect}
  luxon: {DateTime}
  \../../classes/order.ls : Klass
  \../data/order.json : data
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
    <[id startAmount remainingAmount executedAmount price averagePrice]>.for-each (name) ->
      specify "#name key is Number", ->
        expect i.(name) .to.be.a \number
    <[pair side status]>.for-each (name) ->
      specify "#name key is String", ->
        expect i.(name) .to.be.a \string
    specify "datetime key is DateTime instance", ->
      expect i.datetime .to.be.an.instanceof DateTime
    [
      * \isTerminated, no
      * \isUnterminated, yes
      * \isCanceled, no
    ].for-each ([name, val]) ->
      specify "#name key is #val", ->
        expect i.(name) .to.equal val
  describe \methods, ->
    describe "update is successful", ->
      i = Klass.from data
      i.update {} <<< data <<< status: \CANCELED_UNFILLED
      [
        * \isTerminated, yes
        * \isUnterminated, no
        * \isCanceled, yes
      ].for-each ([name, val]) ->
        specify "#name key is #val", ->
          expect i.(name) .to.equal val
