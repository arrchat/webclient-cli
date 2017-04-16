// view <name>
// creates new view

module.exports = (name) => {
  copyTpl('view/index.styl',   `${process.cwd()}/views/{0}/index.styl`,   { name });
  copyTpl('view/index.pug',    `${process.cwd()}/views/{0}/index.pug`,    { name });
  copyTpl('view/index.js',     `${process.cwd()}/views/{0}/index.js`,     { name });
}
