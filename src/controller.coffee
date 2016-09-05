# controller <name>
# creates new controller

module.exports = (name) ->
  copyTpl 'controller/index.coffee', process.cwd() + '/controllers/' + name + '/index.coffee', controller: name
