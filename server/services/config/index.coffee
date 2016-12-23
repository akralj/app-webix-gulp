# use code from configService-old and configCtrl-old to do autorisation here
#
#

_             = require("lodash")
NeDb          = require('nedb')
service       = require('feathers-nedb')
hooks         = require('../../hooks')


module.exports = ->
  app = this
  db = new NeDb({filename: "#{app.serverConfig.dbRoot}/config.db", autoload: true})
  # put some stuff in
  db.remove {}, { multi: true }, (err, res) ->
    clientConfig = require("./clientConfigInDevMode").map (item) ->
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
