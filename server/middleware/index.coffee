#
#
#

handler = require('feathers-errors/handler')
notFound = require('./not-found-handler')
logger = require('./logger')
#addHeaders    = require('./middleware/addHeadersFromWaf')

module.exports = ->
  # Add your custom middleware here. Remember, that just like Express the order matters,
  # so error handling middleware should go last.
  app = this
  app.use(notFound()) # whenever route is not found page not found is emmited
  app.use(logger(app))
  app.use(handler())


###

# custom error code
# A basic error handler, just like Express
.use((err, req, res, next) ->
  res.statusCode = err.code if err?.code
  if err?.errors
    res.json(message: err.message, errors: err.errors)
  else res.send err.message
)

###