require! {
  \../functions/subscriber.ls : get-subscriber
  \../classes/depth.ls : Depth
}
key = \sub-c-e12e9174-dd60-11e6-806b-02ee2ddab7fe

module.exports = (pair, state) ->
  get-subscriber "depth_#pair", key
    .. |> -> if state then it.on ->
      | state.depth =>
        state.depth.update it
      | _ =>
        state.depth = Depth.from it
