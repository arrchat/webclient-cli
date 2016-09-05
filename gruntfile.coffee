module.exports = (grunt) ->
  json = grunt.file.readJSON 'package.json'
  rimraf = require 'rimraf'
  glob = require 'glob'
  path = require 'path'
  ejs = require 'ejs'

  grunt.initConfig
    pkg: json
    coffee:
      commands:
        files: [
          expand: true
          cwd: 'src/'
          src: [ '*.coffee', '!cli.coffee']
          dest: 'dist/'
          ext: '.js'
        ]
        options:
          bare: true
      cli:
        files:
          'dist/cli.js': 'dist/cli.js'
        options:
          bare: true

  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'cleanup', ->
    rimraf.sync 'dist'

  grunt.registerTask 'cli', ->
    done = this.async()
    glob 'src/*.coffee', (err, files) ->
      return grunt.log.errorlns if err?
      data =
        commands: []
        version: json.version
      for file in files
        content = grunt.file.read file
          .split '\n'
        if content[0].startsWith('# ') and content[1].startsWith('# ')
          usage = content[0].slice 2, -1
          descr = content[1].slice 2, -1
          data.commands.push
            name: usage
            description: descr
            action: 'require \'./' + path.basename(file, '.coffee') + '.js\''
      grunt.file.write 'dist/cli.js', ejs.render (grunt.file.read 'src/cli.coffee'), data, escape: (s) -> s
      done()



  grunt.registerTask 'default', [ 'cleanup', 'coffee:commands', 'cli', 'coffee:cli' ]
