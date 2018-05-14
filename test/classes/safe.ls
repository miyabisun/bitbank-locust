require! {
  chai: {expect}
  \../../classes/safe.ls : Klass
  \../data/safe.json : data
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
    [
      * \from, \jpy
      * \to, \xrp
      * \money, 1000
      * \amount, 100
    ].for-each ([name, val]) ->
      specify "#name key is #val", ->
        expect i.(name) .to.equal val
  describe \methods, ->
    describe "update successful", ->
      i = Klass.from data
      i.update {} <<< data <<< xrp: \200.0000, jpy: \800.0000
      [
        * \money, 800
        * \amount, 200
      ].for-each ([name, val]) ->
        specify "#name key is #val", ->
          expect i.(name) .to.equal val
