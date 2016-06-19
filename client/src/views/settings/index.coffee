#
#
#

settingsView =
  general: require('./general')
  bookingTime: require('./bookingTime')


getListItems = (id) ->
  $$("settingsView").removeView("settingsShell") if $$("settingsShell")
  $$("settingsView").addView(webix.copy(settingsView[id]))
  $$("mainSettingsTable").parse(webix.copy(app.config[id]))


settingsTreeView =
  {
    view:"tree"
    id: "settingsTreeView"
    data: [
      {id: "general", value:"Allgemein"}
      {id: "bookingTime", value:"buchungszeiten"}
    ]
    width: 200
    select:true
    on:
      onAfterSelect: (id) -> getListItems(id)
      onAfterLoad: ->
        webix.delay => @select(@getFirstId())
  }


module.exports =
  view: "form"
  type: "wide"
  id: "settings"
  width: "100%"
  height: "100%"
  elements:[
    {view: "template", template: "Einstellungen", type: "header"}
    {
      id: "settingsView"
      cols:[
        settingsTreeView
        { view:"resizer" }
      ]
    }
  ]
