gulp = require('gulp')
shell = require('gulp-shell')
runSequence = require('run-sequence')
bs = require("browser-sync")
serverConfig = require("./server/services/config/serverConfig")
inline = require('gulp-inline')
uglify = require('gulp-uglify')
minifyCss = require('gulp-minify-css')


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

# copy assets, like images, fonts to server/public dir
gulp.task 'copyAssets', ->
  gulp.src(['client/dist/lib/webix/fonts/**/*']).pipe(gulp.dest('server/public/fonts'))
  gulp.src(['client/dist/assets/**/*']).pipe(gulp.dest('server/public/assets'))

# bundles app into one html file
gulp.task 'packJsandCssToOneHtml', ->
  gulp.src('client/dist/index.html')
  .pipe(inline({
    base: 'client/dist/',
    js: uglify,
    css: minifyCss
  })).pipe gulp.dest('server/public/')


gulp.task "createProductionApp", (callback) -> runSequence 'copyAssets', 'packJsandCssToOneHtml', callback


# needs sudo restart app-appName on server as sysadmin
# Staging
gulp.task('cpServerDir',shell.task("rsync -avhP --delete --stats server/ /apps/#{serverConfig.appName}/server/"))
gulp.task('cpPackageJson',shell.task("rsync -avhP --delete --stats server/ /apps/#{serverConfig.appName}/server/"))
gulp.task('installNpmModules', shell.task("cd /apps/#{serverConfig.appName} && npm install --production"))


# Production
gulp.task('copyToProduction', shell.task("rsync -avhP --delete --stats server/ sanode@serverName:/apps/#{serverConfig.appName}/server/"))


# missing automation
# 1. install node modules
# npm i --production
# 2. restart service
#sudo restart APP_NAME
# 3. check if service is still running
#curl https://APP_DOMAIN_NAME/api/isOnline
