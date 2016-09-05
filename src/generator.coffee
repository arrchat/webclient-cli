# generator <name>
# creates new generator

module.exports = (name) ->
  mkdir __dirname + '/../templates/' + name
  copyTpl 'generator/command.coffee', process.cwd() + '/src/' + name + '.coffee', generator: name
  copyTpl 'generator/template.coffee', process.cwd() + '/templates/' + name + '/index.coffee', generator: name
