require! {
  chai: {expect}
  \./order.ls
  \../../../../functions/api/private/cancel.ls : main
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect main .to.be.a \function
