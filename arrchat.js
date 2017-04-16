const cli = require('commander');
cli.version('<%= version %>');

const fs = require('fs');
const path = require('path');
const mkdirp = require('mkdirp');
const colors = require('colors');
const ejs = require('ejs');

global.mkdir = dest => mkdirp.sync(path.dirname(path.normalize(dest)));

// https://gist.github.com/wvffle/0deea63696b993c7364c9d7ecfa1ecf1
String.prototype.format = function format() {
  const args = arguments;
  return this.replace(/\{\d+\}/g, a => {
    a = args[a.slice(1, -1)];
    return a != null ? a : '';
  });
}

global.copy = (src, dest) => {
  dest = path.normalize(dest);
  mkdir(dest);
  const read = fs.createReadStream(src);
  read.pipe(fs.createWriteStream(dest));
  read.on('end', () => {
    console.log('created '.green + dest);
  });
}

global.copyTpl = (src, dest, data) => {
  src = path.normalize(`${__dirname}/../templates/${src}`);
  dest = path.normalize(dest.format(data.name));
  const renderdata = {
    camel: str => str.replace(/(\-[a-z])/g, m => m.toUpperCase().slice(1)),
  };

  for (let key in data) {
    if (data.hasOwnProperty(key)) {
      const value = data[key];
      renderdata[key] = path.basename(value);
    }
  }

  const escape = s => s.replace(/__%/g, '<'+'%').replace(/%__/g, '%'+'>');
  const content = fs.readFileSync(src).toString();

  mkdir(dest);
  fs.writeFileSync(dest, ejs.render(content, renderdata, { escape }));
  console.log('created '.green + dest);
}
<% commands.forEach(function(command) { %>
cli.command('<%= command.name %>')
  .description('<%= command.description %>')
  .action(<%= command.action %>);
<% }) %>
cli.parse(process.argv);

if (!process.argv.slice(2).length) cli.outputHelp();
