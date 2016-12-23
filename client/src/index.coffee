#
#
#


# global requires
window._ = require("lodash")
window.app = require('ampersand-app')
require('./lib/webix/i18n/de')
webix.i18n.setLocale("de-DE")
webix.Date.startOnMonday = true
# define custom validation rules
webix.rules.isNotEmptySelect = (val) -> not _.isEmpty(val)
webix.rules.positiveNumberOrIsEmpty = (val) ->
  return true if val >= 0
  return true if _.isEmpty(val)
webix.rules.positiveNumber = (val) -> return true if val >= 0

app.extend
  config: {}
  router: require('./router')
  store: {}

configCtrl = require("./config")

# get app resources from server before party begins
configCtrl((serverConfig) ->

  webix.ui
    rows: [
      {view: "template", template: "App name kommt hierher", type: "header", css:"appHeaderBackground"}
      cols:[
        require('./views/sidemenu')
        { view:"resizer" }
        require('./views/mainView')
      ]
    ]

  # start with whatever url was given and include #! in url
  app.router({hashbang: true, dispatch: true})

  require("./store")
  # globale event listener
  require("./events")

)
