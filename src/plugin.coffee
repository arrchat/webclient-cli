# plugin <name>
# creates new plugin

module.exports = (name) ->
  copyTpl 'plugin/index.coffee', process.cwd() + '/plugins/' + name + '/index.coffee', plugin: name
