# <%= generator %> <name>
# creates new <%= generator %>

module.exports = (name) ->
  mkdir process.cwd() + '/<%= generator %>'
