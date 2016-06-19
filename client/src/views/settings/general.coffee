#
#
#

methods = require("../../methods")

resourceTable =
  id: "mainSettingsTable"
  view:"datatable"
  editable: true
  editaction: "dblclick"
  columns: [
    {id:"displayName", header: "Einstellung", width: 200}
    {id:"value", header: "Wert", editor:"text", fillspace: true}
  ]

  on:
    onAfterEditStop: (state, editor, ignoreUpdate) ->
      unless @data.getMark(editor.row, 'webix_invalid')
        methods.updateConfigStore("general", "mainSettingsTable" )
      else
        webix.message type:"error", text: 'da hast Du dich vertippt'



module.exports =
  id: "settingsShell"
  view: "layout"
  rows:[
    resourceTable
  ]
