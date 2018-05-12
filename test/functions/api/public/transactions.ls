require! {
  chai: {expect}
  luxon: {DateTime}
  \../../../../functions/api/public/transactions.ls : main
  \node-bitbankcc : {public-api}
}
api = public-api!

file = "test#{__filename - /^.*test/}"
describe file, ->
  s = result: null, main: null
  before ->>
    s.promise = main api, \xrp_jpy, \20180501
    s.result = await s.promise
  describe \type, ->
    specify "is function", ->
      expect main .to.be.a \function
    specify "return is Promise", ->
      expect s.promise .to.be.an.instanceof Promise
  describe \transations, ->
    specify "is object", ->
      expect s.result .to.be.a \object
    describe "has transactions", ->
      transactions = -> s.result.transactions
      specify "is array", ->
        expect transactions! .to.be.an \array
      describe \children, ->
        transaction = -> transactions!.0
        specify "transaction_id is number", ->
          expect transaction!.transaction_id .to.be.a \number
        specify "side is string", ->
          expect transaction!.side .to.be.a \string
        specify "price is '0.000' string", ->
          expect transaction!.price .to.match /^\d+\.\d{3}$/
        specify "amount is '0.0000' string", ->
          expect transaction!.amount .to.match /^\d+\.\d{4}$/
        specify "executed_at is valid unix time", ->
          time = DateTime.from-millis transaction!.executed_at
          expect time.is-valid, time.invalid-reason .to.be.ok
