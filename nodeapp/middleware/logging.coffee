
module.exports = ()->
  return (req, res, next)->
    if req.url == "/"
      console.log 'nodeapp', 'middleware'
    next()
