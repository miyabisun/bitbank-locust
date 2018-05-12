require! {
  chai: {expect}
  luxon: {DateTime}
  \../../../../functions/api/public/ticker.ls : main
  \node-bitbankcc : bitbank
}
api = bitbank.public-api!

file = "test#{__filename - /^.*test/}"
describe file, ->
  s = result: null, promise: null
  before ->>
    s.promise = main api, \xrp_jpy
    s.result = await s.promise
  describe \type, ->
    specify "is functions", ->
      expect main .to.be.a \function
    specify "return is Promise", ->
      expect s.promise .to.be.an.instanceof Promise
  describe \result, ->
    specify "is object", ->>
      expect s.result .to.be.a \object
    describe "properties", ->
      <[sell buy high low last]>.for-each (key) ->
        specify "#key key is '0.000' string", ->
          expect s.result.(key) .to.be.a \string .that.match /^\d+\.\d{3}$/
      specify "vol key is '0.0000' string", ->
        expect s.result.vol .to.be.a \string .that.match /^\d+\.\d{4}$/
      specify "timestamp key is valid unix time", ->
        time = DateTime.from-millis s.result.key
        expect time, time.invalidReason .to.have.property \isValid, yes
