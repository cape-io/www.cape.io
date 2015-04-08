React = require 'react'
Router = require 'react-router'
http = require 'superagent'

User = require './model/user'
Routes = require './routes'
processData = require './processData'

inBrowser = typeof window isnt "undefined"

# The goal with this is to have the server and client call the same function to
# init the app.
App = (data, render, onError, onAbort) ->
  if not data.path then data.path = '/'
  # Process the initial data. (index.json)
  data = processData(data)
  if inBrowser
    data.me = new User()
    data.me.checkSession()
  console.log 'Init react with data.'
  Render = (Handler, state) ->
    if not inBrowser and not state.routes.length
      return onAbort {notFound: true}
    # This is the default props sent to the Index view.
    #console.log React.renderToStaticMarkup(React.createElement(Handler, data))
    render Handler, data

  if inBrowser
    # Attach app to global window var as app.
    window.app = data
    Router.run Routes, Router.HistoryLocation, Render
  else
    r = Router.create {
      routes: Routes
      location: data.path
      onError: onError
      onAbort: onAbort
    }
    r.run Render

if inBrowser
  window.onload = -> # Attach event handlers.
    # This is created specific to the client.
    render = (Handler, props) ->
      React.render React.createElement(Handler, props), document
    # Load up the data to pass to the App function.
    http.get('/index.json').accept('json').end (err, res) =>
      if err or !res?.body
        # Do nothing when we don't get the data.
        return console.error err or res
      # Trigger render.
      App res.body, render

module.exports = App
