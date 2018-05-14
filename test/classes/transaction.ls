require! {
  chai: {expect}
  luxon: {DateTime}
  \../../classes/transaction.ls : Klass
  \../data/transactions.json
}
data = transactions.transactions.0

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Klass .to.be.an \function
    specify "return is instance", ->
      expect Klass.from data .to.be.an.instanceof Klass
  describe \instance, ->
    i = Klass.from data
    <[id price amount]>.for-each (key) ->
      specify "#key key is number", ->
        expect i.(key) .to.be.a \number
    specify "side key is string", ->
      expect i.side .to.be.a \string
    specify "datetime key is DateTime instance", ->
      expect i.datetime .to.be.an.instanceof DateTime
