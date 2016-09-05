# view <name>
# creates new view

module.exports = (name) ->

  copyTpl 'templates/view/view.styl', process.cwd() + '/views/' + name + '/' + name + '.styl', view: name
  copyTpl 'templates/view/view.pug', process.cwd() + '/views/' + name + '/' + name + '.pug', view: name
  copyTpl 'templates/view/index.coffee', process.cwd() + '/views/' + name + '/index.coffee', view: name
