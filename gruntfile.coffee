module.exports = (grunt) ->
  json = grunt.file.readJSON 'package.json'
  rimraf = require 'rimraf'
  glob = require 'glob'
  path = require 'path'

  grunt.initConfig
    pkg: json
    coffee:
      commands:
        files: [
          expand: true
          cwd: 'src/'
          src: '*.coffee'
          dest: 'dist/'
          ext: '.js'
        ]
        options:
          bare: true

  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'cleanup', ->
    rimraf.sync 'dist'

  grunt.registerTask 'cli', ->
    done = this.async()
    glob 'src/*.coffee', (err, files) ->
      return grunt.log.errorlns if err?
      cli = 'var cli;\n\ncli = require(\'commander\');\n\ncli.version(\'' + json.version + '\');\n\n'
      for file in files
        content = grunt.file.read file
          .split '\n'
        if content[0].startsWith('# ') and content[1].startsWith('# ')
          usage = content[0].slice 2, -1
          descr = content[1].slice 2, -1
          cli += 'cli.command(\'' + usage + '\', \'' + descr + '\')\n\t.action(require(\'./' + path.basename(file, '.coffee') + '.js\'));\n\n'
      cli += 'cli.parse(process.argv);\n'
      grunt.file.write 'dist/cli.js', cli
      done()

  grunt.registerTask 'default', [ 'cleanup', 'coffee', 'cli' ]
