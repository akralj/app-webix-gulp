# methods used in frontend code
#
#

updateConfigStore = (id, table) ->
  data = _.toArray($$(table).data.pull)
  app.config[id] = data
  console.log  id, data
  lastUpdate =
    clientId: app.store.config.connection.id
    updatedAt: new Date()
    #user:   app.config.auth.user
    #groups: app.config.auth.groups

  app.store.config.update(id, {data: data, lastUpdate: lastUpdate} ).then((res) -> console.log res).catch((err) -> console.log err, "error")


isInReadWriteGroup = (auth_groups) ->
  if (_.intersection(app.config?.auth?.authConfig?.readWriteGroups, auth_groups)).length > 0
    true
  else false

module.exports =
  updateConfigStore: updateConfigStore
  isInReadWriteGroup: isInReadWriteGroup

