require! {
  chai: {expect}
  \../../modules/api.ls : main
  \../../config.ls : {api-key, api-secret}
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect main .to.be.a \function
    specify "return is object", ->
      api = main \xrp_jpy, api-key, api-secret
      expect api .to.be.a \object
    describe "api test successfuly", ->
      api = main \xrp_jpy, api-key, api-secret
      specify "depth", ->>
        result = await api.depth!
        expect result .to.be.a \object
      specify "assets", ->>
        result = await api.assets!
        expect result .to.be.a \object
