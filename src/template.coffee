# template <name>
# creates new template

module.exports = (name) ->
  copyTpl 'template/template.pug', process.cwd() + '/templates/{0}.pug', template: name
