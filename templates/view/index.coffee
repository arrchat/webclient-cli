# <%= view %> view

app.directive '<%= view %>', [
  '$rootScope'
  ($scope) ->
    restrict: 'C'
    templateUrl: 'views/<%= view %>/<%= view %>.html'
    link: (scope, $el) ->
      <%= view %> = $el[0]

]
