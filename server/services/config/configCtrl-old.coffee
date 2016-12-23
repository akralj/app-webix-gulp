# manges config which can be changed by user
#
#

_ = require("lodash")
# keep track of configuration
_config = {} # private member
config = {}  # exported config

# can only be called once, when app starts up
constructor = (clientConfig) ->
  clientConfig.forEach (item) ->
    _config[item.id] = item.data
    Object.defineProperty(config, "#{item.id}",
      {
        get: -> return _config[item.id]
        set: (val) ->
          if val?.id and val?.data and _.isArray val.data
            #console.log "setting", val
            _config[val.id] = val.data
          else console.log "cant set config, because of wrong args"
      }
    )


module.exports =
  config: config
  constructor: _.once(constructor)

