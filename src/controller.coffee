# controller <name>
# creates new controller

module.exports = (name) ->
  copyTpl 'controller/index.coffee', process.cwd() + '/controllers/{0}/index.coffee', controller: name
