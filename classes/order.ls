require! {
  luxon: {DateTime}
}

module.exports = class Order
  (@entity) ->
  @from = -> new Order it
  id:~ -> @entity.order_id
  pair:~ -> @entity.pair
  side:~ -> @entity.side
  start-amount:~ -> parse-float @entity.start_amount
  remaining-amount:~ -> parse-float @entity.remaining_amount
  executed-amount:~ -> parse-float @entity.executed_amount
  price:~ -> parse-float @entity.price
  average-price:~ -> parse-float @entity.average_price
  datetime:~ -> DateTime.from-millis @entity.ordered_at
  status:~ -> @entity.status
  is-terminated:~ -> not @is-unterminated
  is-unterminated:~ -> @entity.status in <[UNFILLED PARTIALLY_FILLED]>
  is-canceled:~ -> @entity.status in <[CANCELED_UNFILLED CANCELED_PARTIALLY_FILLED]>
