# template <name>
# creates new template

module.exports = (name) ->
  copyTpl 'template/template.pug', process.cwd() + '/templates/' + name + '/' + name + '.pug', template: name
