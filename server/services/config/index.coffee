# supplies client with config values
#
#

_             = require('underscore')
NeDb          = require('nedb')
service       = require('feathers-nedb')
hooks         = require('../../hooks')


module.exports = ->
  app = this
  db = new NeDb({filename: "#{app.serverConfig.dbRoot}/config.db", autoload: true})
  # put some stuff in and remove in production if you want user settings
  db.remove {}, { multi: true }, (err, res) ->
    clientConfig = require("./clientConfigDefault")(app.env).map (item) ->
      {_id: item.id, data: item.data}
    db.insert clientConfig, (err, res) -> #console.log err, res

  opts =
    Model: db
    paginate:
      default: 100000
      max: 100000

  app.use "config", service(opts).extend({
    before:
      all: [hooks.changeId2_id]

    after:
      all: [hooks.change_id2id]
  })


###
auth code from jsh-admin

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
###
