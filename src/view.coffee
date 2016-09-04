# view <view> [views...]
# creates new view

module.exports = (view, views = []) ->

  console.log view, views

  views.unshift view

  fs = require 'fs'
  copy = (src, dest) ->
    read = fs.createReadStream src
    read.pipe fs.createWriteStream dest

  for view in views
    copy 'templates/view/view.styl', process.cwd() + '/views/' + view + '/' + view + '.styl'
    copy 'templates/view/view.pug', process.cwd() + '/views/' + view + '/' + view + '.pug'
    copy 'templates/view/index.coffee', process.cwd() + '/views/' + view + '/index.coffee'
