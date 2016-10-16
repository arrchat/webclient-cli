# generator <name>
# creates new generator

module.exports = (name) ->
  mkdir __dirname + '/../templates/' + name
  copyTpl 'generator/command.coffee', __dirname + '/../src/{0}.coffee', generator: name
  copyTpl 'generator/template.coffee', __dirname + '/../templates/{0}/index.coffee', generator: name
