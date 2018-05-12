require! {
  pubnub: PubNub
  ramda: R
  \prelude-ls : P
}

# subscriber :: String -> String -> Object
module.exports = (channel, subscribe-key) ->
  listener = <[status message presence]>
    |> P.map -> [it, new Set()]
    |> R.from-pairs
  (pubnub = new PubNub {subscribe-key})
    ..subscribe channels: [channel]
    ..add-listener core-listener =
      message: (msg) -> listener.message.for-each (fn) -> fn msg.message.data
  return
    on: (fn) -> listener.message.add fn
    off: (fn) -> listener.message.delete fn
    has: (fn) -> listener.message.has fn
    stop: -> pubnub.stop!
