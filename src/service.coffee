# service <name>
# creates new service

module.exports = (name) ->
  copyTpl 'service/index.coffee', process.cwd() + '/services/' + name + '/index.coffee', service: name
