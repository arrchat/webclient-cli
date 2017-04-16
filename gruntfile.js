module.exports = (grunt) => {
  const json = grunt.file.readJSON('package.json');
  const {spawn} = require('child_process');
  const ejs = require('ejs');

  grunt.initConfig({
    pkg: json,
  });

  grunt.registerTask('arrchat', function() {
    const cwd = 'commands/';
    const files = grunt.file.expand({ cwd }, ['*.js']);
    const data = {
      commands: [],
      version: json.version,
    };

    for (let file of files) {
      const content = grunt.file.read(`${cwd}${file}`);
      const lines = content.split('\n');

      if (lines[0].startsWith('// ') && lines[1].startsWith('// ')) {
        const name = lines[0].slice(3);
        const description = lines[1].slice(3);

        data.commands.push({
          name,
          description,
          action: `require('../${cwd}${file}')`,
        });

        console.log(`Adding '${cwd}${file}'`);
      }
    }

    const cli = grunt.file.read(`arrchat.js`);
    grunt.file.write('cli/arrchat.js', '#!/usr/bin/env node\n' + ejs.render(cli, data, { escape: s => s }));
  });

  grunt.registerTask('readme', function() {
    spawn('npm', ['run', 'readme']);
  });

  grunt.registerTask('default', [ 'arrchat', 'readme' ]);
}
