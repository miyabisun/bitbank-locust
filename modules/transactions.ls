require! {
  \../functions/subscriber.ls : get-subscriber
  \../classes/transactions.ls : Transactions
}
key = \sub-c-e12e9174-dd60-11e6-806b-02ee2ddab7fe

# transactions :: String -> Object -> Object
module.exports = (pair, state) ->
  get-subscriber "transactions_#pair", key
    ..on -> state.transactions = Transactions.from it
