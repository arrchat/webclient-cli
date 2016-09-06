# style <name>
# creates new style

module.exports = (name) ->
  copyTpl 'style/style.coffee', process.cwd() + '/styles/' + name + '.styl', style: name
