# <%= view %> view

app.directive '<%= camel(view) %>', [
  '$rootScope'
  ($scope) ->
    unless $load.views['<%= view %>'] == !0
      $load.views['<%= view %>'] = !0
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/<%= view %>/<%= view %>.css'
    restrict: 'C'
    templateUrl: 'views/<%= view %>/<%= view %>.html'
    link: (scope, $el) ->
      <%= camel(view) %> = $el[0]

]
