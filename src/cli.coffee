cli = require 'commander'
cli.version '<%= version %>'

fs = require 'fs'
path = require 'path'
mkdirp = require 'mkdirp'
colors = require 'colors'
ejs = require 'ejs'

global.copy = (src, dest) ->
  dest = path.normalize dest
  mkdirp.sync (path.dirname dest), parseInt '0777', 8
  read = fs.createReadStream src
  read.pipe fs.createWriteStream dest
  read.on 'end', ->
    console.log 'created '.green + dest

global.copyTpl = (src, dest, data) ->
  dest = path.normalize dest
  mkdirp.sync (path.dirname dest), parseInt '0777', 8
  fs.readFile src, (err, content) ->
    throw err if err?
    content = content.toString()
    fs.writeFile dest, (ejs.render content, data, escape: (s) -> s), (err) ->
      throw err if err?
      console.log 'created '.green + dest

<% commands.forEach(function(command) { %>
cli.command '<%= command.name %>'
  .description '<%= command.description %>'
  .action <%= command.action %>
<% }) %>

cli.parse process.argv

cli.outputHelp() if !process.argv.slice(2).length
