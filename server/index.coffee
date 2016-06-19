# main server file
# feathers server gets composed here
#

# 1. get config from db and init config controller
configService = require('./lib/config/configService')
configService.init (err, configCtrl) ->
  serverConfig = configCtrl.config.server
  # 2. start the party

  feathers      = require('feathers')
  rest          = require('feathers-rest')
  socketio      = require('feathers-socketio')
  hooks         = require('feathers-hooks')
  compression   = require('compression')
  bodyParser    = require('body-parser')
  cors          = require('cors')
  addHeaders    = require('./lib/addHeadersFromWaf')
  dataService   = require('./lib/dataService')


  # Create a feathers instance.
  app = feathers()

  app.use(cors()) # needed for tests
  .use(compression())
  .configure(socketio())
  .configure(rest())
  .use(bodyParser.json())
  .use(bodyParser.urlencoded(extended: true))
  .use(addHeaders) # supplies feathers with user, groups and ip from WAF
  .configure(hooks())
  .use("/data", dataService)
  .use("/config", configService.service)
  .set("views", "/apps/jungschar/share")
  .use("/", feathers.static(serverConfig.clientCode))

  # A basic error handler, just like Expres
  .use((err, req, res, next) ->
    res.statusCode = err.code if err?.code
    if err?.errors
      res.json(message: err.message, errors: err.errors)
    else res.send err.message
  )

  # devPort is used only in dev, otherwise upstart env var
  port = process.env.PORT or serverConfig.appPort
  app.listen port, ->
    console.log 'Feathers server listening on port ' + port
