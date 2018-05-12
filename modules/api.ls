require! {
  \require-dir
  \node-bitbankcc : bitbank
  \prelude-ls : P
}

module.exports = (pair, key, secret) ->
  [
    * \public, bitbank.public-api!
    * \private, bitbank.private-api key, secret
  ]
  |> P.map ([name, api]) ->
    require-dir "../functions/api/#name"
    |> P.Obj.map (fn) -> (...args) -> fn.apply null, [api, pair] ++ args
  |> P.fold1 (<<<)
