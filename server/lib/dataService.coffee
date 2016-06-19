# validates data and takes care of neDb database
#
#

Joi           = require('joi')
errors        = require('feathers-errors').types
_             = require('underscore')
NeDb          = require('nedb')
service       = require('feathers-nedb')
methods       = require('./methods')
serverConfig  = require("./config/configCtrl").config.server

db = new NeDb({filename: "#{serverConfig.dbRoot}/data.db", autoload: true})


# put some stuff in
db.remove {}, { multi: true }, (err, res) ->
  dummyData = require("../../test/data/films.json")
  dummyData.forEach (data) ->
    db.insert data, (err, res) ->
      console.log "inserted #{data._id}"


opts =
  Model: db
  paginate:
    default: 100
    max: 200


module.exports = service(opts).extend({
  before:
    all: (hook, next) ->
      console.log hook.data
      if hook.data and hook.params?.auth_user
        hook.data.user = hook.params.auth_user
      # change id to _id for noSql db
      if hook?.data?.id
        hook.data._id = hook.data.id
        delete hook.data.id
      next()

  after:
    all: (hook, next) ->
      # change _id -> id
      # 1. when pagination is enabled
      if _.isArray hook?.result?.data
        hook.result.data = hook.result.data.map (item) -> methods.normalizeId(item)
      # 2. no pagination
      else if _.isArray hook?.result
        hook.result = hook.result.map (item) -> methods.normalizeId(item)
      # 3. get request
      else if hook?.result?._id
        hook.result = methods.normalizeId(hook.result)
      next()
})

