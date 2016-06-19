# validates data and takes care of nedb database
#
#

Joi           = require('joi')
errors        = require('feathers-errors').types
_             = require('underscore')
NeDb          = require('nedb')
feathersService = require('feathers-nedb')
methods       = require('../methods')
configCtrl    = require("./configCtrl")
serverConfig  = require("./serverConfig")


if process.env.APP_ENV is "development" or process.env.APP_ENV is "testing"
  extraConfig = serverConfig[process.env.APP_ENV]
  serverConfig = _.extend(serverConfig,extraConfig)
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


validate = (hook, next) ->
  next()
  ###
  schema = require("../schema/config")
  Joi.validate hook.data, schema, (err, value) ->
    #console.log "validating", err, value, hook.id
    # if err then hook.data._error = {name: err.name, details: err.details}
    next()
  ###


service = feathersService({Model: db}).extend({
    before:
      all: (hook, next) ->
        if hook.data and hook.params?.auth_user
          hook.data.user = hook.params.auth_user
        # change id to _id for noSql db
        if hook?.data?.id
          hook.data._id = hook.data.id
          delete hook.data.id
        next()
      update: [methods.isInReadWriteGroup, validate]

    after:
      all: (hook, next) ->
        if _.isArray hook?.result
          # change _id -> id
          hook.result = hook.result.map (item) -> methods.normalizeId(item)
          # add auth info when comlete config is requested
          if hook?.params?.auth_user
            hook.result.push(id: "auth", data: {user: hook.params.auth_user, groups: hook.params.auth_groups, authConfig: serverConfig?.authConfig})
        else if hook?.result?._id
          hook.result = methods.normalizeId(hook.result)
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
