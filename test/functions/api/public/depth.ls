require! {
  chai: {expect}
  luxon: {DateTime}
  \../../../../functions/api/public/depth.ls : main
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
      <[asks bids]>.for-each (board) ->
        specify "#board key is array", ->
          expect s.result.(board) .to.be.an \array
        describe board, ->
          describe "#board children", ->
            specify "is array", ->
              s.result.(board).for-each expect >> (.to.be.an \array)
            specify "[0] price key is '0.000' string", ->
              s.result.(board).for-each (.0) >> expect >> (.to.be.a \string) >> (.that.match /^\d+.\d{3}$/)
            specify "[1] amount key is '0.0000' stirng", ->
              s.result.(board).for-each (.1) >> expect >> (.to.be.a \string) >> (.that.match /^\d+.\d{4}$/)
      specify "timestamp key is valid unix time", ->
        time = DateTime.from-millis s.result.key
        expect time, time.invalidReason .to.have.property \isValid, yes
