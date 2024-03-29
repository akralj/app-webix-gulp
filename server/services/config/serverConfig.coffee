#
#
#

_ = require("lodash")
packageConfig = require("../../../package.json")
appName = packageConfig.name
appPort = 7777

config =
  appName: appName
  appUser: "user who is running the production daemon"
  appPort: appPort
  appVersion: packageConfig.version
  serverName: "prodServer"
  clientCode: "/apps/#{appName}/server/public"
  dbRoot: "/apps/#{appName}/db"
  authConfig:
    readOnlyGroups: ["someGroup_r", "anotherGroup_r"]
    readWriteGroups: ["someOtherGroup_rw"]
  service:
    contacts:
      serverUrl: "http://localhost:7777/contacts"
      imageFolder: "/apps/assets/images/contact"
      imageUrl: "/assets/images/contact"


module.exports = (env) ->
  if env is "development"
    development =
      serverName: "devi"
      dbRoot: "./db"
      liveReloadPort: appPort + 2000 # by my convention
      clientCode: "./client/dist"

    _.merge(config, development)

  else if env is "testing"
    testing=
      serverName: "diolappdev01"
      dbRoot:     "./test/db"
      appPort:    appPort + 9
    _.merge(config, testing)

  #console.log config
  return config
