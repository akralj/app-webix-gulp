#
#
#

winston = require('winston')

module.exports = (app) ->
  # Add a logger to our app object for convenience
  app.logger = winston
  (error, req, res, next) ->
    if error
      message = (if error.code then '(' + error.code + ') ' else '') + 'Route: ' + req.url + ' - ' + error.message
      if error.code == 404
        winston.info message
      else
        winston.error message
        winston.info error.stack
    next error
