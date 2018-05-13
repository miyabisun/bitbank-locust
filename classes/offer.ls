module.exports = class Offer
  (@entity = []) ->
  @from = -> new Offer it
  price:~ -> parse-float @entity.0 or 0
  amount:~ -> parse-float @entity.1 or 0
