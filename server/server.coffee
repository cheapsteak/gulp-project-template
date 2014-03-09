path     = require 'path'
express  = require 'express'
mongoose = require 'mongoose'

DATABASE = 'mongodb://localhost/my-app'

app = express()

app.configure ->
  app.use express.static path.join __dirname, '../', 'public'
  app.use express.json()
  app.use express.urlencoded()

  mongoose.connect DATABASE

app.configure 'production', ->
  app.use express.logger()
  app.set 'json spaces', 0

# Controllers
require('./controllers/fruit') app

app.listen 9001
