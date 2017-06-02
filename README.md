# app-webix-gulp (used to be: app)
## used in projects till 2017-06-02
### is needed for docs of old projects


# Feathers/Webix Starter Kit -> app dev made easy

## Parts
- [Feathers](http://feathersjs.com) for RESTfull services
- [Webix](www.webix.com) for UI components
- [Prova](https://github.com/akralj/prova) for tape tests
- [Browsersync](https://browsersync.io) for syncing app windows during dev


## Installation
- tested in ubuntu 14.04/16.04 and node 6.x
- install node.js(6.x) and git, eg. on ubuntu

``` sh
# install dependencies on ubuntu
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo add-apt-repository ppa:git-core/ppa --yes
sudo apt-get update
# install all packages
sudo apt-get install --yes git nodejs
```
- clone repo and install npm dependencies:

``` sh
git clone https://github.com/akralj/app-webix-gulp
cd app-webix-gulp
# global modules
npm install -g gulp coffeescript
npm install
# start app in dev mode
gulp
```
Point your browser to:
[http://localhost:9777](http://localhost:9777) for example app
[http://localhost:3001](http://localhost:3001) to configure browsersync

Server is restarted, whenever server code changes.
Browser refreses, whenever client code changes.

## First steps (optional)
- change name, version, description & author in package.json -> this will be used in server/services/config/serverConfig.coffee
- change serverName, ports,... in server/services/config/serverConfig.coffee to match your enviroment
- start with a fresh git repo
``` sh
rm -rf .git
git init
git add .
git commit -am "initial commit"
# add your own remote origin
git remote set-url origin ssh://git@YourSourcecodeServer/projectName/appName.git
git push origin
```

## Which files go where
- client/dist/index.html -> basic app skelteon with meta tags
- client/src/views -> views
- client/lib -> libs used in multiple places
- server/ -> server code
- test/ -> tests and fixtures
- lib/ -> shared client & server code


## Build task in development
- gulp compiles client code to ./client/dist and refreshes browser


## Testing

``` sh
npm test
```
starts tap tests in /test
