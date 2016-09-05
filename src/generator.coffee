# generator <name>
# creates new generator

module.exports = (name) ->
  mkdir __dirname + '/../templates/' + name
  copyTpl 'generator/command.coffee', __dirname + '/../src/' + name + '.coffee', generator: name
  copyTpl 'generator/template.coffee', __dirname + '/../templates/' + name + '/index.coffee', generator: name
