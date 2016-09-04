# view <name>
# creates new view

module.exports = (name) ->

  fs = require 'fs'
  path = require 'path'
  mkdirp = require 'mkdirp'

  copy = (src, dest) ->
    dest = path.normalize dest
    mkdirp.sync (path.dirname dest), parseInt '0777', 8
    read = fs.createReadStream src
    read.pipe fs.createWriteStream dest
    read.on 'end', ->
      console.log 'created '+ dest

  copy 'templates/view/view.styl', process.cwd() + '/views/' + name + '/' + name + '.styl'
  copy 'templates/view/view.pug', process.cwd() + '/views/' + name + '/' + name + '.pug'
  copy 'templates/view/index.coffee', process.cwd() + '/views/' + name + '/index.coffee'
