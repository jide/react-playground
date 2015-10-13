{CompositeDisposable} = require 'atom'
url = require 'url'
path = require 'path'
fs = require 'fs'

WebBrowserPreview = require './react-playground-view'

module.exports =
  config:
    port:
      type: 'integer'
      description: 'Webpack server port.'
      default: 8612

  activate: (state) ->
    me = @

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-react-playground:toggle': => @toggle()

    atom.workspace.addOpener (uriToOpen) ->
      try
        {protocol, host, pathname} = url.parse(uriToOpen)
      catch error
        return

      return unless protocol is 'react-playground:'

      uri = url.parse(uriToOpen)
      uri.protocol = "http:"

      new WebBrowserPreview(path: uri.pathname)

  toggle: ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    file = editor?.buffer.file
    filePath = file?.path
    dirPath = path.dirname(filePath)
    playgroundPath = path.join(dirPath, '.playground.js')

    if (fs.existsSync(playgroundPath))
      # Only allow one instance
      previewPane = atom.workspace.paneForURI(uri)
      if previewPane
        previewPane.destroyItem(previewPane.itemForURI(uri))

      uri = "react-playground://#{dirPath}"

      previousActivePane = atom.workspace.getActivePane()
      atom.workspace.open(uri, split: 'right', activatePane: false, searchAllPanes: true).then ->
        previousActivePane.activate()
    else
      alert('No .playground.js file found')

  deactivate: ->
    @subscriptions.dispose()
