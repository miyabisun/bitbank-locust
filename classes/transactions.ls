require! {
  \./transaction : Transaction
  ramda: R
}

module.exports = class Transactions
  (@entity) ->
    @items = @entity.transactions.map Transaction.from
  @from = -> new Transactions it
  add: (entity) -> entity.transactions?.for-each ~>
    @items.push Transaction.from it
  leave: (length) ->
    @items = @items.slice R.max 0, (@items.length - length)
