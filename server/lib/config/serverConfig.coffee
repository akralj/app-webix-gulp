#
#
#

packageConfig = require("../../../package.json")
appName = packageConfig.name
appPort = 7777

module.exports =
  appName: appName
  appRoot: "./server"
  appPort: appPort
  appVersion: packageConfig.version
  serverName: "prodServerName"
  clientCode: "./server/public"
  dbRoot: "/apps/#{appName}"
  sharePath: "/apps/#{appName}/share"
  authConfig:
    readOnlyGroups: ["someGroup_r", "anotherGroup_r"]
    readWriteGroups: ["someOtherGroup_rw"]
  mail:
    server:
      host: 'smtp.yourServerName.at'
      port: 25
    templatesPath: "/apps/#{appName}/share/templatesDir"

  development:
    serverName: "devi"
    dbRoot: "./server/db"
    liveReloadPort: appPort + 2000 # by my convention
    clientCode: "./client/dist"

  testing:
    serverName: "devi"
    dbRoot:     "./test/db"
    appPort:    7778

