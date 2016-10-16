# view <name>
# creates new view

module.exports = (name) ->

  copyTpl 'view/view.styl', process.cwd() + '/views/{0}/{0}.styl', view: name
  copyTpl 'view/view.pug', process.cwd() + '/views/{0}/{0}.pug', view: name
  copyTpl 'view/index.coffee', process.cwd() + '/views/{0}/index.coffee', view: name
