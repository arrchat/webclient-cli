# plugin <name>
# creates new plugin

module.exports = (name) ->
  copyTpl 'plugin/index.coffee', process.cwd() + '/plugins/{0}/index.coffee', plugin: name
