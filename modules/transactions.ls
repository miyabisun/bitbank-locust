require! {
  \../functions/subscriber.ls : get-subscriber
}
key = \sub-c-e12e9174-dd60-11e6-806b-02ee2ddab7fe

module.exports = (pair) ->
  get-subscriber "transactions_#pair", key
