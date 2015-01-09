React = require 'react'
_ = require 'queries'
Router = require 'react-router'
{Route, DefaultRoute} = Router

data = require './data'
#data.content = require './data/content'

Routes = require './routes'

inBrowser = typeof window isnt "undefined"

App = (vars, render) ->
  props =
    name: 'app'
    path: vars.path or '/'

  Render = (Handler) ->
    render Handler, {data: data, vars: vars}

  if inBrowser
    Router.run Routes, Router.HistoryLocation, Render
  else
    Router.run Routes, props.path, Render

if inBrowser
  window.onload = -> # Attach event handlers.
    # Attach app to global window var as app.
    window.app =
      db: data # Our database.
    render = (Handler, props) ->
      React.render React.createElement(Handler, props), document
    App {}, render

module.exports = App
