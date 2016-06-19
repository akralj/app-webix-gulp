gulp = require('gulp')
shell = require('gulp-shell')
runSequence = require('run-sequence')
bs = require("browser-sync")
serverConfig = require("./server/lib/config/serverConfig")


# DEFAULT
#----------------------------------------------------------------------------------------------------------------------
gulp.task 'default', ['watch', 'reload', 'restServer']


# Reload
#----------------------------------------------------------------------------------------------------------------------
gulp.task 'browser-sync', ->
  bs.init null,
    proxy: "http://localhost:#{serverConfig.appPort}"
    port:   serverConfig.development.liveReloadPort # port which one can connect to proxied app
    ws:     true   # makes websockets work
gulp.task 'reload', [ 'browser-sync' ], ->
  gulp.watch './client/dist/**/*.html', bs.reload
  gulp.watch './client/dist/**/*.js', bs.reload
  #gulp.watch './src/**/*.css', bs.reload


# Client
#------------------------------------------------------------------------------------------------------------------
gulp.task('watch'
  , shell.task("watchify -t coffeeify client/src/index.coffee -o client/dist/bundle.js --verbose --extension='.coffee'"))


# Server
#------------------------------------------------------------------------------------------------------------------
gulp.task('restServer'
  , shell.task("APP_ENV=development supervisor --watch server --ignore server/public server/index.coffee"))


# Tests
#------------------------------------------------------------------------------------------------------------------
gulp.task "test", shell.task(["coffee test/index.coffee"])


gulp.task 'copyWebixPro', shell.task("rsync -avhP --delete --stats ../assets/webix ./client/dist/lib/webix/")


# needs sudo restart app-appName on server as sysadmin
# gulp.task('copyRemote', shell.task("rsync -avhP --delete --stats server/ sanode@serverName:/apps/AppName/server/"))
# bundles app into one html file and copies it with all assets, like images to public
#gulp.task "createProd", (callback) -> runSequence 'copyRemote', callback


# missing automation
# 3. restart service
#sudo restart APP_NAME
# 4. check if service is still running
#curl https://APP_DOMAIN_NAME/api/isOnliners

