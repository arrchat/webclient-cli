# style <name>
# creates new style

module.exports = (name) ->
  copyTpl 'style/style.styl', process.cwd() + '/styles/{0}.styl', style: name
