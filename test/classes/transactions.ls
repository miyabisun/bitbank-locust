require! {
  chai: {expect}
  luxon: {DateTime}
  \../../classes/transactions.ls : Klass
  \../../classes/transaction.ls : Transaction
  \../data/transactions.json : data
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect Klass .to.be.an \function
    specify "return is instance", ->
      expect Klass.from data .to.be.an.instanceof Klass
  describe \instance, ->
    i = Klass.from data
    specify "items key is array of Transaction", ->
      expect i.items .to.be.an \array .that.length-of 2
      i.items.for-each expect >> (.to.be.an.instanceof Transaction)
  describe \methods, ->
    describe "merge successful", ->
      i = Klass.from data
      i.merge data
      specify "items key is array of Transaction", ->
        expect i.items .to.be.an \array .that.length-of 4
        i.items.for-each expect >> (.to.be.an.instanceof Transaction)
