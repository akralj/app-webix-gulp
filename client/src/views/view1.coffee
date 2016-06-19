#
#
#

module.exports =
  view:"datatable"
  id: "view1"
  width: "100%"
  tooltip: true
  url:  "rest->/data"
  save:
    url:  "rest->/data"
    autoupdate:true
  editable: true
  editaction: "click"
  #select: true
  scroll: 'xy'
  autoConfig: true
  ###
  columns:[
    {id: "id", header: "Id", sort: "int", width: 80 }
  ]
  ###