bodyParser = require 'body-parser'
express    = require 'express'
mongoose   = require 'mongoose'
path       = require 'path'

DATABASE = 'mongodb://localhost/my-app'

app = express()

app.use express.static path.join __dirname, '../', 'public'
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)

mongoose.connect DATABASE

if process.env.NODE_ENV == 'production'
  app.use express.logger()
  app.set 'json spaces', 0

# Controllers
require('./controllers/fruit') app

app.listen 9001
