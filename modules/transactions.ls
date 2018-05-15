require! {
  \../functions/subscriber.ls : get-subscriber
  \../classes/transactions.ls : Transactions
}
key = \sub-c-e12e9174-dd60-11e6-806b-02ee2ddab7fe

module.exports = (pair, state) ->
  get-subscriber "transactions_#pair", key
    .. |> -> if state then it.on ->
      | state.transactions =>
        state.transactions.add it
      | _ =>
        state.transactions = Transactions.from it
