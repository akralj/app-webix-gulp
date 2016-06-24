# Feathers/Webix Starter Kit -> app dev made easy

## Parts used
- [Feathers](http://feathersjs.com) for RESTfull server
- [Webix](www.webix.com) UI components
- [Prova](https://github.com/akralj/prova) test runner based on tape
- [Browsersync](https://browsersync.io) for syncing app during dev

## Installation
- tested under ubuntu 14.04 and node 6.x (works under node 4.x too)
- install node.js(6.x) and git, eg. on ubuntu

``` sh
# add reps
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo add-apt-repository ppa:git-core/ppa --yes
sudo apt-get update
# install all packages
sudo apt-get install --yes git nodejs htop xsel samba unzip nginx
```
- clone repo and install npm dependencies:

``` sh
git clone git@github.com:akralj/app.git
cd app
rm -rf .git
git init

npm install -g gulp coffee-script
npm install
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


## So wird entwickelt:
- client/dist/index.html basic app skelteon with meta tags
- client/src/views -> views
- client/lib -> libs used in multiple places
- server/ -> server code
- test/ tests and fixtures
- lib/ shared client & server code


## Build Task development
- gulp compiles client code to ./client/dist and refreshes browser



## Testing

``` sh
gulp test
```
starts tape tests



