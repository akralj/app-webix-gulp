# validates data and takes care of neDb database
#
#

_             = require('underscore')
NeDb          = require('nedb')
service       = require('feathers-nedb')
hooks         = require('../../hooks')


module.exports = ->
  app = this
  db = new NeDb({filename: "#{app.serverConfig.dbRoot}/data.db", autoload: true})
  # put some stuff in
  db.remove {}, { multi: true }, (err, res) ->
    dummyData = require("./dummyData.json")
    dummyData.forEach (data) ->
      db.insert data, (err, res) -> #console.log "inserted #{data._id}"

  opts =
    Model: db
    paginate:
      default: 10
      max: 200

  app.use "data", service(opts).extend({
    before:
      all: [hooks.changeId2_id, hooks.myHook]

    after:
      all: [hooks.change_id2id]
  })
