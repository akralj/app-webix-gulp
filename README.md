# Feathers/Webix Starter Kit -> app dev made easy

## Parts used
- [Feathers](http://feathersjs.com) for RESTfull services
- [Webix](www.webix.com) for UI components
- [Prova](https://github.com/akralj/prova) for tape tests
- [Browsersync](https://browsersync.io) for syncing app windows during dev

## Installation
- tested in ubuntu 14.04 and node 6.x (works in node 4.x too)
- install node.js(6.x) and git, eg. on ubuntu

``` sh
# add reps
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo add-apt-repository ppa:git-core/ppa --yes
sudo apt-get update
# install all packages
sudo apt-get install --yes git nodejs
```
- clone repo and install npm dependencies:

``` sh
git clone git@github.com:akralj/app.git
cd app
rm -rf .git
git init
# global modules
npm install -g gulp coffee-script
npm install
# start app in dev mode
gulp
```
Point your browser to [http://localhost:9007](http://localhost:9007)

[http://localhost:3001](http://localhost:3001) browsersync admin

## First steps
- change name, version, description & author in package.json -> this will be used in server/lib/config/serverConfig.coffee
- change serverName, ports,... in server/lib/config/serverConfig.coffee to match your enviroment
- git add .
- git commit -am "initial commit"
- add your own remote origin, e.g. git remote set-url origin ssh://git@YourSourcecodeServer/projectName/appName.git
- git push


## Development how-to:
- changes of server or client code either restarts server or refreshes browser
- client/dist/index.html basic app skelteon with meta tags
- client/src/views -> views
- client/lib -> libs used in multiple places
- server/ -> server code
- test/ tests and fixtures
- lib/ shared client & server code


## Build task in development
- gulp compiles client code to ./client/dist and refreshes browser


## Testing

``` sh
gulp test
```
starts tape tests
