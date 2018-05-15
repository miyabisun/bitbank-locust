require! {
  chai: {expect}
  \../../modules/transactions.ls : main
  \../../classes/transactions.ls : Transactions
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  s = transactions: null, subscriber: null, pair: \btc_jpy
  before ->
    s.subscriber = main s.pair, s
  after ->
    s.subscriber.stop!
  describe \type, ->
    specify "is function", ->
      expect main .to.be.an \function
    specify "result is object", ->
      expect s.subscriber .to.be.a \object
  describe "successful", ->
    @timeout 60_000ms
    # モジュールの動作を変えた時だけ検証する
    specify.skip "state update", ->>
      new Promise (resolve) ->
        do fn = ->
          | s.transactions =>
            expect s.transactions .to.be.an.instanceof Transactions
            resolve s.transactions
          | _ => set-timeout fn, 200
    specify.skip \on, ->>
      new Promise (resolve) ->
        fn = ->
          expect it .to.be.a \object
          resolve it
        s.subscriber.on fn
    specify \has, ->
      console.log
      s.subscriber.on (fn = ->)
      expect s.subscriber.has fn .to.be.true
    specify "off", ->
      s.subscriber.on (fn = ->)
      s.subscriber.off fn
      s.subscriber.has fn |> expect >> (.to.be.false)
