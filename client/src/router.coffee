# click im treeview zeigt die hier verlinken Komponenten an
#
#

router = require('page')

render = (view) ->
  $$('sideMenu').select(view)
  console.log "switching to view:", view
  $$(view).show()


router '/', -> render('view1')

router '/view1', -> render('view1')
router '/view2', -> render('view2')
router '/settings', -> render('settings')

router '/404', -> $$('404').show()


# catch all
router '*', -> router '404'

module.exports = router