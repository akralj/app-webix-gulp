#
#
#

_ = require("underscore")
packageConfig = require("../../../package.json")
appName = packageConfig.name
appPort = 7007

config =
  appName: appName
  appRoot: "./server"
  appPort: appPort
  appVersion: packageConfig.version
  serverName: "prodServerName"
  clientCode: "./server/public"
  dbRoot: "/apps/#{appName}/db"
  #sharePath: "/apps/#{appName}/share"
  authConfig:
    readOnlyGroups: ["someGroup_r", "anotherGroup_r"]
    readWriteGroups: ["someOtherGroup_rw"]
  mail:
    server:
      host: 'smtp.yourServerName.at'
      port: 25
    templatesPath: "/apps/#{appName}/share/templatesDir"


module.exports = (env) ->
  if env is "development"
    development =
      serverName: "userv"
      dbRoot: "./db"
      liveReloadPort: appPort + 2000 # by my convention
      clientCode: "./client/dist"
    _.extend(config, development)

  else if env is "testing"
    testing=
      serverName: "userv"
      dbRoot:     "./test/db"
      appPort:    7008
    _.extend(config, testing)

  return config
