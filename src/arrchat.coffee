cli = require 'commander'
cli.version '<%= version %>'

fs = require 'fs'
path = require 'path'
mkdirp = require 'mkdirp'
colors = require 'colors'
ejs = require 'ejs'

global.mkdir = (dest) ->
  mkdirp.sync (path.dirname path.normalize dest), parseInt '0777', 8

# https://gist.github.com/wvffle/0deea63696b993c7364c9d7ecfa1ecf1
String::format = ->
  args = arguments
  @replace /\{\d+\}/g, (a) ->
    a = args[a.slice(1, -1)]
    if a? then a else ''

global.copy = (src, dest) ->
  dest = path.normalize dest
  mkdir dest
  read = fs.createReadStream src
  read.pipe fs.createWriteStream dest
  read.on 'end', ->
    console.log 'created '.green + dest

global.copyTpl = (src, dest, data) ->
  src = path.normalize __dirname + '/../templates/' + src
  dest = path.normalize dest.format data[Object.keys(data)[0]]
  bdata = 
    camel: (str) ->
      str.replace /(\-[a-z])/g, (m) ->
        m.toUpperCase().slice 1
  for key, value of data
    bdata[key] = path.basename value
  mkdir dest
  escape = (s) ->
    s = s.replace /__%/g, '<' + '%'
    s = s.replace /%__/g, '%' + '>'
    s
  fs.readFile src, (err, content) ->
    throw err if err?
    content = content.toString()
    fs.writeFile dest, (ejs.render content, bdata, escape: escape), (err) ->
      throw err if err?
      console.log 'created '.green + dest

<% commands.forEach(function(command) { %>
cli.command '<%= command.name %>'
  .description '<%= command.description %>'
  .action <%= command.action %>
<% }) %>

cli.parse process.argv

cli.outputHelp() if !process.argv.slice(2).length
