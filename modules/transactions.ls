require! {
  \../functions/subscriber.ls : get-subscriber
  \../classes/transactions.ls : Transactions
}
key = \sub-c-e12e9174-dd60-11e6-806b-02ee2ddab7fe

module.exports = (pair, state) ->
  get-subscriber "transactions_#pair", key
    .. |> ->
      | state => it.on ->
        state.transactions = Transactions.from it
