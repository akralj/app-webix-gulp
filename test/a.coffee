#
#
#

_ = require("lodash-mixins")
tap = require('tap')


tap.ok('this is fine')

tap.test "some Test", (t) ->
  t.plan 1
  t.equals 2,2
