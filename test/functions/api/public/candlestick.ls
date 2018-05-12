require! {
  chai: {expect}
  luxon: {DateTime}
  \../../../../functions/api/public/candlestick.ls : main
  \node-bitbankcc : {public-api}
}
api = public-api!

file = "test#{__filename - /^.*test/}"
describe file, ->
  s = result: null, main: null
  before ->>
    s.promise = main api, \xrp_jpy, \1day, 2018
    s.result = await s.promise
  describe \type, ->
    specify "is function", ->
      expect main .to.be.a \function
    specify "return is Promise", ->
      expect s.promise .to.be.an.instanceof Promise
  describe \transations, ->
    specify "is object", ->
      expect s.result .to.be.a \object
    describe "properies", ->
      candlestick = -> s.result.candlestick
      specify "candlestick key is array", ->
        expect candlestick! .to.be.an \array
      describe "candlestick children", ->
        target = -> candlestick!.find (.type is \1day)
        specify "is object", ->
          expect target! .to.be.a \object
        specify "type key is string", ->
          expect target!.type .to.be.a \string
        specify "ohlcv key is array", ->
          expect target!.ohlcv .to.be.an \array
        describe "ohlcv children", ->
          ohlcv = -> target!.ohlcv
          specify "is array", ->
            expect ohlcv! .to.be.an \array
          describe \children, ->
            <[open high low close]>.for-each (name, key) ->
              specify "[#key] #name key is '0.000' string", ->
                expect ohlcv!.0.(key) .to.be.a \string .that.match /^\d+.\d{3}$/
            specify "[4] valume key is '0.0000' string", ->
              expect ohlcv!.0.4 .to.be.a \string .that.match /^\d+.\d{4}$/
            specify "[5] timestamp key is valid unix time", ->
              time = DateTime.from-millis ohlcv!.0.5
              expect time, time.invalidReason .to.have.property \isValid, yes
      specify "timestamp key is valid unix time", ->
        time = DateTime.from-millis s.result.key
        expect time, time.invalidReason .to.have.property \isValid, yes
