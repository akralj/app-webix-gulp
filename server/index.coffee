#
#
#

app = require("./app")

# devPort is used only in dev, otherwise upstart env var
port = process.env.PORT or app.serverConfig.appPort
server = app.listen(port)
server.on 'listening', ->
  console.log("Feathers service running on port: #{port}")
