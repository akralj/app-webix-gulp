# Feathers/Webix Starter Kit -> app dev made easy

## Parts
- [Feathers](http://feathersjs.com) for RESTfull services
- [Webix](www.webix.com) for UI components
- [Prova](https://github.com/akralj/prova) for tape tests
- [Browsersync](https://browsersync.io) for syncing app windows during dev


## Installation
- tested in ubuntu 14.04/16.04 and node 8.x (works in node ^7.6 to)
- install node.js(8.x) and git, eg. on ubuntu

``` sh
# install dependencies on ubuntu
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo add-apt-repository ppa:git-core/ppa --yes
sudo apt-get update
# install all packages
sudo apt-get install --yes git nodejs
```
- clone repo and install npm dependencies:

``` sh
git clone https://github.com/akralj/app
cd app
# global modules
npm install -g gulp coffee-script
npm install
# start app in dev mode
gulp
```
Point your browser to:
[http://localhost:9007](http://localhost:9007) for example app
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
