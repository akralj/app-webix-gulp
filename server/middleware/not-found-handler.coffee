errors = require('feathers-errors')

module.exports = ->
  (req, res, next) ->
    next new (errors.NotFound)('Page not found')
