# this was to complicated, so we will rewrite it in a simpler fashion
# 
#

errors        = require('feathers-errors').types
_             = require("lodash")
NeDb          = require('nedb')
feathersService = require('feathers-nedb')
hooks         = require('../../hooks')
configCtrl    = require("./configCtrl")
serverConfig  = require("./serverConfig")

normalizeId = (obj) ->
  if obj._id
    obj.id = obj._id
    delete obj._id
  obj


if process.env.APP_ENV is "development" or process.env.APP_ENV is "testing"
  extraConfig = serverConfig[process.env.APP_ENV]
  serverConfig = _.extend(serverConfig, extraConfig)
  delete serverConfig.development; delete serverConfig.testing


db = new NeDb({filename: "#{serverConfig.dbRoot}/config.db", autoload: true})

init = (cb) ->
  # for development we just use a config file, which is written to db
  if process.env.APP_ENV is "development"
    clientConfig  = require('./clientConfigInDevMode')
    clientConfig2 = clientConfig.map (item) -> {_id: item.id, data: item.data}

    clientConfig.push({id:"server", data: serverConfig})
    configCtrl.constructor(clientConfig)

    db.remove {}, {multi: true}, (err, res) ->
      db.insert clientConfig2, (err, res) ->
        console.log "inserted dev config"
        cb err, configCtrl
  else
    # production config from config.db
    db.find {}, (err, res) ->
      clientConfig = res.map (item) -> {id: item._id, data: item.data}
      configCtrl.constructor(clientConfig)
      cb err, configCtrl


service = feathersService({Model: db}).extend({
    before:
      all: [hooks.changeId2_id]
      #update: [hooks.isInReadWriteGroup, validate]

    after:
      all: (hook, next) ->
        if _.isArray hook?.result
          # change _id -> id
          hook.result = hook.result.map (item) -> normalizeId(item)
          # add auth info when comlete config is requested
          if hook?.params?.auth_user
            hook.result.push(id: "auth", data: {user: hook.params.auth_user, groups: hook.params.auth_groups, authConfig: serverConfig?.authConfig})
        else if hook?.result?._id
          hook.result = normalizeId(hook.result)
        next()
      # XXX needs proper id in event not _id
      update: (hook, next) ->
        configCtrl.config[hook.id] = {id: hook.id, data: hook.data.data}
        next()
      patch: (hook, next) ->
        configCtrl.config[hook.id] = {id: hook.id, data: hook.data.data}
        next()
  })


module.exports =
  service:  service
  init:     init
