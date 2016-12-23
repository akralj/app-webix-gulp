# Add any common hooks you want to share across services in here.
# see http://docs.feathersjs.com/hooks/readme.html for more details on hooks.
#

_           = require("lodash")


normalizeId = (obj) ->
  if obj._id
    obj.id = obj._id
    delete obj._id
  obj


module.exports =
  # change id to _id for noSql db
  changeId2_id: (hook, next) ->
    if hook?.data?.id
      hook.data._id = hook.data.id
      delete hook.data.id
    next()

  # change _id -> id
  change_id2id: (hook, next) ->
    # 1. when pagination is enabled
    if _.isArray hook?.result?.data
      hook.result.data = hook.result.data.map (item) -> normalizeId(item)
    # 2. no pagination
    else if _.isArray hook?.result
      hook.result = hook.result.map (item) -> normalizeId(item)
    # 3. get request
    else if hook?.result?._id
      hook.result = normalizeId(hook.result)
    next()


  normalizeParams: (hook, next) ->
    query = hook.params.query
    console.log hook.params
    if hook.params.provider is "rest"
      numberFields = ["duration"]
      Object.keys(query).forEach (key) ->
        # parse booleans
        if query[key] is 'true'  then query[key] = true
        if query[key] is 'false' then query[key] = false
        # parse numbers
        if key in numberFields then query[key] = parseInt(query[key])

    next()



###
moment      = require("moment")
moment.locale("de")
normalizeDatetime = (datetime) ->
  if datetime?
    moment(datetime).format().slice(0,19)
  else moment().format().slice(0,19)

###
