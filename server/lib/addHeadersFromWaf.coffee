# WAF headers werden zum feathers object hinzugefügt
#
#

_       = require("underscore")



module.exports = (req, res, next) ->
  if process.env.APP_ENV is "development"
    req.feathers.auth_user = "dev.user"
    req.feathers.auth_groups = ["aGroup_r", "aGroup_rw"]

  else if req.headers?.auth_user
    #console.log "auth from header", req.headers.auth_user#, req.headers.auth_groups
    req.feathers.auth_user = req.headers.auth_user
    req.feathers.auth_groups = req.headers.auth_groups.toLowerCase().split(',')
    req.feathers.clientIp = req.headers['x-forwarded-for'] or req.connection.remoteAddress

  next()

