feathers = require('feathers-client')
socket = require('socket.io-client')()
featherApp = feathers().configure(feathers.socketio(socket))

app.store.data = featherApp.service('data')

normalizeEvent = (obj) ->
  if obj._id
    obj.id = obj._id
    delete obj._id
  obj

eventTable = $$("eventTable")


app.store.data.on 'created', (obj) ->
  obj = normalizeEvent(obj)
  #console.log "created:", obj
  eventTable.add(obj)


app.store.data.on 'updated', (obj) ->
  console.log obj, "updated"
  obj = normalizeEvent(obj)
  #console.log "obj updated", obj
  eventTable.updateItem(obj.id, obj)


# gets new history back from server
app.store.data.on 'patched', (obj) ->
  obj = normalizeEvent(obj)
  console.log obj, "patched"
  #console.log "obj patched", obj
  eventTable.updateItem(obj.id, obj)


# not needed for now
#app.store.data.on 'removed', (obj) -> #$$("dtable").remove(obj._id)

app.store.config = featherApp.service('config')
# app.store.config.patch("config",{"general.reservationTimeSpan": 7}).then((res) -> console.log res)
