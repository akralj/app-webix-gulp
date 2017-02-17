#
#
#

_ = require("lodash-mixins")
tap = require('tap')


tap.test "some failing test", (t) ->
  t.plan 1
  t.equals 2,2
