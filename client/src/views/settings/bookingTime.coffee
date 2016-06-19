#
#
#

methods = require("../../methods")

resourceTable =
  id: "mainSettingsTable"
  view:"datatable"
  editable: true
  editaction: "dblclick"
  fixedRowHeight: false
  rowLineHeight: 25
  rowHeight: 25
  resizeColumn:true
  autoConfig: true
  #columns: [
  #  {id:"type", header: "Art", width: 150, }
  #]

  on:
    onAfterEditStop: (state, editor, ignoreUpdate) ->
      unless @data.getMark(editor.row, 'webix_invalid')
        methods.updateConfigStore("blockedDates", "mainSettingsTable" )
        # passt die höhe der Zeilen wieder richtig an
        @adjustRowHeight("message", true)
        @render()

      else
        webix.message type:"error", text: 'da hast Du dich vertippt'


module.exports =
  id: "settingsShell"
  view: "layout"
  width: "100%"
  height: "100%"
  rows:[
    resourceTable
  ]
