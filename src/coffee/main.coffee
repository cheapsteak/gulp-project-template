React = require 'react'
$     = require 'jquery'

RadComponent = require './rad-component.cjsx'

$ ->
  React.render RadComponent({rad:"mos def"}),
      document.getElementById('container')
