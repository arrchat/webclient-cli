# <%= view %> view

app.directive '<%= view %>', [
  '$rootScope'
  ($scope) ->
    restrict: 'C'
    link: (scope, $el) ->
      <%= view %> = $el[0]

]
