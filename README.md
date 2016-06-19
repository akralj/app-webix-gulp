# Feathers/Webix Starter Kit -> app dev made easy

## Was wird verwendet
- [Feathers](http://feathersjs.com) für den Serverteil
- [Webix](www.webix.com) Componenten fürs UI
- [Prova](https://github.com/akralj/prova) zum clientseitigen Testen
- [Browsersync](https://browsersync.io) to sync it everywhere

## Installation
- getestet under ubuntu 14.04
- Installiere node.js(4.2.x) und git
- öffne ein terminal, cmd.exe oder so was ähnliches und tippe folgendes ein:

``` sh
git clone git@github.com:akralj/app.git
cd app
rm -rf .git
git init

npm install
gulp
```
Öffne eine Browser und gehe zu [http://localhost:9999](http://localhost:9999)

[http://localhost:3001](http://localhost:3001) konfiguriert browsersync

## First steps
- change name, version, description & author in package.json -> this will be used in server/lib/config/serverConfig.coffee
- change serverName, ports,... in server/lib/config/serverConfig.coffee to match your enviroment
- git add .
- git commit -am "initial commit"
- add your own remote origin, e.g. git remote set-url origin ssh://git@YourSourcecodeServer/projectName/appName.git
- git push


## So wird entwickelt:
- client/dist/index.html beinhaltet das html Grundgerüst mit Metadaten
- client/src/views die einzelnen UI-Komponenten
- client/lib beinhaltet fremde oder eigene Bibliotheken
- server/ den server code
- test/ die tests und dummy data
- lib code der sowohl am client als auch am server verwendet wird



## Build Task
- gulp kompiliert automatisch nach server/public für client code

## Testen

``` sh
gulp test
```
startet die tape tests und liefert das Endergebnis im Terminal



