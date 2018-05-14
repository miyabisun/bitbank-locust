require! {
  \./transaction : Transaction
}

module.exports = class Transactions
  (@entity) ->
    @items = @entity.transactions.map Transaction.from
  @from = -> new Transactions it
  merge: (entity) -> entity.transactions?.for-each ~>
    @items.push Transaction.from it
