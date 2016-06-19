# Hauptbereich neben dem Treeview
#
#

module.exports =
  id:"mainView"
  type: "multiview"
  keepViews: true
  animate: false
  cells: [
    require('./view1')
    require('./view2')
    require('./settings')

    {id: "404", template: "die seite ist noch leer, aber bald..."}
  ]
