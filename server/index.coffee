# main server file
# modled after: https://github.com/feathersjs/feathers-chat
#

# time startup
console.time("server startup")


feathers      = require('feathers')
rest          = require('feathers-rest')
socketio      = require('feathers-socketio')
hooks         = require('feathers-hooks')
compression   = require('compression')
bodyParser    = require('body-parser')
cors          = require('cors')
path          = require('path')
addHeaders    = require('./middleware/addHeadersFromWaf')


# Create a feathers instance.
app = feathers()
# add global serverConfig which can be used in services
app.serverConfig = require("./services/config/serverConfig")(process.env.APP_ENV)

app.use(compression())
.options('*', cors()).use(cors()) # needed for tests
# not sure if this is needed specifically
#.use(favicon( path.join(app.serverConfig.clientCode, 'favicon.ico') ))
.use("/", feathers.static(app.serverConfig.clientCode))
.use(bodyParser.json())
.use(bodyParser.urlencoded(extended: true))
.configure(hooks())
.configure(socketio())
.configure(rest())
#.use(addHeaders) # supplies feathers with user, groups and ip from WAF
.configure(require('./services/config'))
.configure(require('./services/data'))


# A basic error handler, just like Express
.use((err, req, res, next) ->
  res.statusCode = err.code if err?.code
  if err?.errors
    res.json(message: err.message, errors: err.errors)
  else res.send err.message
)

# devPort is used only in dev, otherwise upstart env var
port = process.env.PORT or app.serverConfig.appPort
server = app.listen(port)
server.on 'listening', ->
  console.timeEnd("server startup")
  console.log("Feathers service running on 127.0.0.1:#{port}")
