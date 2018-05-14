require! {
  \./offer.ls : Offer
  \prelude-ls : P
}

module.exports = class Depth
  (@entity) ->
  @from = -> new Depth it
  asks:~ -> @entity.asks.map Offer.from
  bids:~ -> @entity.bids.map Offer.from
  ask-of: (i) -> @entity.asks.(i - 1) |> Offer.from
  bid-of: (i) -> @entity.bids.(i - 1) |> Offer.from
  update: -> @entity = it
