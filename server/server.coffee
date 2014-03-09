path    = require 'path'
express = require 'express'

app = express()

app.configure ->
  app.use express.static path.join __dirname, '../', 'public'

app.get '/api/bananas', (req, res) ->
  res.send [
    id: 1
    weight: 100
  ,
    id: 2
    weight: 125
  ]

app.listen 9001
