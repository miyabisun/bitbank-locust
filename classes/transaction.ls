require! {
  luxon: {DateTime}
}

module.exports = class Transaction
  (@entity) ->
  @from = -> new Transaction it
  id:~ -> @entity.transaction_id
  side:~ -> @entity.side
  price:~ -> parse-float @entity.price
  amount:~ -> parse-float @entity.amount
  datetime:~ -> DateTime.from-millis @entity.executed_at
