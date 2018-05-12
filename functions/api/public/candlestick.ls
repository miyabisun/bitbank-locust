# candlestick :: PublicApi -> String -> String -> Number -> Promise
module.exports = (api, pair, type, year) ->>
  await api.get-candlestick pair, type, year
