
module.exports = (app)->
  app.get '/about', (req, res)->
    res.end('<h1>About '+ app.get('info').name +'</h1>')
