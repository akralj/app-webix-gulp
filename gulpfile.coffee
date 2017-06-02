gulp        = require('gulp')
shell       = require('gulp-shell')
runSequence = require('run-sequence')
bs          = require("browser-sync")
inline      = require('gulp-inline')
uglify      = require('gulp-uglify')
cleanCSS    = require('gulp-clean-css')

serverConfig = require("./server/services/config/serverConfig")("production")


# DEFAULT
#------------------------------------------------------------------------------------------------------------------
gulp.task 'default', ['watch', 'reload', 'restServer']


# Reload
#------------------------------------------------------------------------------------------------------------------
gulp.task 'browser-sync', ->
  serverConfig = require("./server/services/config/serverConfig")("development")
  bs.init null,
    proxy: "http://localhost:#{serverConfig.appPort}"
    port:   serverConfig.liveReloadPort # port which one can connect to proxied app
    ws:     true   # makes websockets work
gulp.task 'reload', [ 'browser-sync' ], ->
  gulp.watch './client/dist/**/*.html', bs.reload
  gulp.watch './client/dist/**/*.js', bs.reload
  #gulp.watch './src/**/*.css', bs.reload


# Client
#------------------------------------------------------------------------------------------------------------------
gulp.task('watch'
  , shell.task("watchify -t coffeeify client/src/index.coffee -o client/dist/bundle.js --verbose --extension='.coffee'")
)


# Server
#------------------------------------------------------------------------------------------------------------------
gulp.task('restServer'
  , shell.task("APP_ENV=development supervisor --watch server --ignore server/public server/index.coffee"))


# Tests
#------------------------------------------------------------------------------------------------------------------
# headless testing with chromium, ubuntu server needs: sudo apt-get install xvfb chromium-browser
gulp.task "test", shell.task(["coffee test -b -l chromium -e"])


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
    css:cleanCSS #minifyCss
  })).pipe gulp.dest('server/public/')

# Production: test on prod server with: APP_ENV=production coffee server/index.coffee
#----------------------------------------------------------------------------------------------------------------
gulp.task 'createProd', (callback) ->
  runSequence 'createProductionApp', 'copyToProduction', 'copyModulesToProduction', callback
gulp.task "createProductionApp", (callback) -> runSequence 'copyAssets', 'packJsandCssToOneHtml', callback
gulp.task('copyToProduction', shell.task("rsync -avhP --delete --stats server/ sanode@#{serverConfig.serverName}:/apps/#{serverConfig.appName}/server/"))
gulp.task('copyModulesToProduction', shell.task("rsync -avhP --delete --stats package.json sanode@#{serverConfig.serverName}:/apps/#{serverConfig.appName}/"))
