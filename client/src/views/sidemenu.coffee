#
#
#

module.exports =
  view: 'menu'
  id: 'sideMenu'
  css: "customColor"
  layout: 'y'
  width: 140
  select: true
  # die id muss mit der id übereinstimmen, die im router und mainview definiert ist
  data:[
    { id:"view1", value:"Übersicht", icon:"eye"}
    { id:"view2", value:"nochEinPunkt", icon:"calendar"}
    { $template:"Spacer" },
    # { id:"share", value:"Dateien", icon:"folder"}
    { id:"settings", value:"Einstellungen", icon:"cog" }
  ]
  on:
    onMenuItemClick: (id) ->
      view = @getMenuItem(id).id
      app.router("/#{view}")

