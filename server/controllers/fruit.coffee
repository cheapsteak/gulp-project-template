mongoose = require 'mongoose'

Fruit = require '../models/fruit'

module.exports = (app) ->

  app.get '/api/fruits', (req, res) ->
    Fruit.find().exec (err, fruits) ->
      return res.send 500, err if err?
      res.send fruits

  app.post '/api/fruits', (req, res) ->
    fruit = new Fruit req.body
    fruit.save (err, fruit) ->
      return res.send 400, err if err?
      res.send 201, fruit
