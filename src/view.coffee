# view <name>
# creates new view

module.exports = (name) ->

  copyTpl 'view/view.styl', process.cwd() + '/views/' + name + '/' + name + '.styl', view: name
  copyTpl 'view/view.pug', process.cwd() + '/views/' + name + '/' + name + '.pug', view: name
  copyTpl 'view/index.coffee', process.cwd() + '/views/' + name + '/index.coffee', view: name
