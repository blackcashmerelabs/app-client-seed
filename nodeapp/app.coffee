
express = require 'express'
fs = require 'fs'
config = require './config'
app = express()

# here's how to set things that routes may need access to
# drivers, loggers, etc..

app.set 'info', {name: config.appinfo}


# serve the optimized static assets

app.configure 'local', ()->
  app.use express.static('app')

app.configure 'develop', ()->
  app.use express.static('app')

app.configure 'prod', ()->
  app.use express.static('build')


# middleware
app.use express.bodyParser()
app.use(require('./middleware/logging')())

# routes
fs.readdirSync(__dirname + '/routes').forEach (file)->
  require('./routes/' + file)(app)


# run..
app.listen config.port
