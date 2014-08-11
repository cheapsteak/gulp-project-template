# Main module

require 'angular'
require 'angular-route'

angular
  .module 'home', ['ngRoute']
  .config ['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when '/',
        template: require './index.jade'
  ]
