require! {
  \prelude-ls : P
}

# info :: PrivateApi -> String -> Number or [Number] -> Promise
module.exports = (api, pair, id) ->>
  if id |> P.is-type \Array
    await api.get-orders-info pair, id
  else
    await api.get-order pair, id
