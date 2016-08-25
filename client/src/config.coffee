feathers = require('feathers-client')
socket = require('socket.io-client')()
featherApp = feathers().configure(feathers.socketio(socket))
# keep track of configuration
_config = {}

app.store.config = featherApp.service('config')


app.store.config.on 'updated', (obj) ->
  console.log "socketio ids", @id, obj.lastUpdate.clientId
  if @id isnt obj.lastUpdate.clientId
    console.log "updating other clients"
    # xxx not working properly
    _config[obj.id] = obj.data
    settingTable = $$("mainSettingsTable")
    selectedRow = settingTable.getSelectedId()
    settingTable.clearAll()
    settingTable.parse(_config[obj.id])
    settingTable.select(selectedRow) if selectedRow


# get config over ajax to set proper header for authentication
module.exports = (cb) ->
  fetch("/config").then((res) -> res.json()).then((serverConfig) ->
    console.log serverConfig
    serverConfig.data.forEach (item) ->
      _config[item.id] = item.data
      # these object cant be overwritten, client side, should be save enough
      Object.defineProperty(app.config, "#{item.id}", { get: -> return _config[item.id]})
    cb(serverConfig)
  )


###
app.store.config.on 'created', (obj) -> console.log "created:", obj
app.store.config.on 'patched', (obj) -> console.log "obj patched", obj
app.store.config.on 'removed', (obj) -> console.log "removed", obj

###