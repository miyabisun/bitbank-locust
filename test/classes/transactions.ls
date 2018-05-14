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
    describe "add successful", ->
      i = Klass.from data
      i.add data
      specify "items key is array of Transaction", ->
        expect i.items .to.be.an \array .that.length-of 4
        i.items.for-each expect >> (.to.be.an.instanceof Transaction)
    describe "leave successful", ->
      i = Klass.from data
      [1 to 10].for-each -> i.add data
      i.leave 5
      specify "items key is array of Transaction", ->
        expect i.items .to.be.an \array .that.length-of 5
        i.items.for-each expect >> (.to.be.an.instanceof Transaction)
