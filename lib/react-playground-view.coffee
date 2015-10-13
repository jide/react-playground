{$, View} = require 'atom-space-pen-views'
{allowUnsafeEval} = require 'loophole'

http = require 'http'
url = require 'url'
path = require 'path'
fs = require 'fs'
merge = require 'merge-deep'

express = allowUnsafeEval -> require 'express'
webpack = require 'webpack'
devMiddleware = require 'webpack-dev-middleware'
hotMiddleware = require 'webpack-hot-middleware'
generateHTML = require './react-playground-html'

module.exports =
class WebBrowserPreview extends View
  @content: (params) ->
    @div =>
      @iframe
        id: 'react-playground-frame'
        src: 'about:blank'
        sandbox: 'allow-same-origin allow-scripts'

  getTitle: ->
    "React playground"

  initialize: (params) ->
    @port = atom.config.get 'react-playground.port'
    @url = "http://127.0.0.1:#{@port}"
    @projectPath = atom.project.getPaths()[0]
    @config = require('./react-playground-webpack')(@projectPath, params.path)
    customConfigPath = path.join(@projectPath, 'playground.config.js')
    if (fs.existsSync(customConfigPath))
      @config = require(customConfigPath)(@config, webpack)
    @startServe()

  detached: ->
    if @server
      @server.close()

  openViewer: ->
    @.find('#react-playground-frame')[0].src = @.url

  startServe: ->
    me = @
    compiler = webpack(@config)
    app = express()
    app.use('/images', express.static(@config.staticPath))
    app.use('/fonts', express.static(@config.staticFontsPath))
    app.use devMiddleware(compiler,
      noInfo: true,
      publicPath: @config.output.publicPath)
    app.use hotMiddleware(compiler,
      log: ->
        return)
    app.get '/', (req, res) ->
      res.send(generateHTML(path.join(me.config.output.publicPath, me.config.output.filename)))
      return
    @server = app.listen @port, 'localhost', (err) ->
      if err
        console.log err
        alert('Error launching server')
        return
      me.openViewer()
