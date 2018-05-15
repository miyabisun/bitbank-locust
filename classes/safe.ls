module.exports = class Safe
  (@entity) ->
  @from = -> new Safe it
  from:~ -> @_from ?= @entity.pair.split \_ .1
  to:~ -> @_to ?= @entity.pair.split \_ .0
  money:~ -> parse-float @entity.(@from)
  amount:~ -> parse-float @entity.(@to)
