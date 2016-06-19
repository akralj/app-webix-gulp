#
#
#

_           = require('underscore')
moment      = require("moment")
moment.locale("de")
errors = require('feathers-errors').types
config = require("../config/configCtrl").config


normalizeDatetime = (datetime) ->
  if datetime?
    moment(datetime).format().slice(0,19)
  else moment().format().slice(0,19)


normalizeId = (obj) ->
  if obj._id
    obj.id = obj._id
    delete obj._id
  obj


isInReadWriteGroup = (hook, next) ->
  # if user is in readWrite groups we show what is underneath authChecker
  # or request comes over socketio, which is only possible from localhost,
  # because WAF blocks websockets (XXX change this if WAF allows sockets one day)
  if (_.intersection(config?.authConfig?.readWriteGroups, hook.params?.auth_groups)).length > 0 or hook.params?.provider is "socketio"
    # console.log "your ok to write:", hook.params
    next()
  else
    next(new (errors.Unprocessable)("no write access", {errors: [{name: "no write access", message: "Kein Schreibzugriff"} ]}) )


module.exports =
  normalizeDatetime:      normalizeDatetime
  normalizeId:            normalizeId
  isInReadWriteGroup:     isInReadWriteGroup

