# service <name>
# creates new service

module.exports = (name) ->
  copyTpl 'service/index.coffee', process.cwd() + '/services/{0}/index.coffee', service: name
