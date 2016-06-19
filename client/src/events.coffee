#
#
#

app = require('ampersand-app')
Favico = require('./lib/favico')
window.favicon = new Favico({  animation:'none'})


# listening for badge changes
app.on("setBadge", (id, val) ->
  # 1. set in internetanfrange tab
  eventsFilter = $$("eventsFilter")
  newRequest = _.findWhere(eventsFilter.config.options, {id: id})
  newRequest.badge = val
  eventsFilter.refresh()
  # 2. set in favicon
  favicon.badge(val)
)