React = require 'react'
_ = require 'queries'
Router = require 'react-router'
{Route, DefaultRoute} = Router

Collection = require 'ampersand-collection'

data = require './data'
domains = _.map data.domains, (domain) ->
  domain.id = domain.sld+'.'+domain.tld
  return domain
data.domains = new Collection domains
#data.content = require './data/content'

Routes = require './routes'

inBrowser = typeof window isnt "undefined"

App = (vars, render) ->
  props =
    name: 'app'
    path: vars.path or '/'

  Render = (Handler) ->
    if inBrowser
      data = window.app.db
    render Handler, {data: data, vars: vars}

  if inBrowser
    Router.run Routes, Router.HistoryLocation, Render
  else
    Router.run Routes, props.path, Render

if inBrowser
  testAPI = ->
    console.log "Welcome!  Fetching your information.... "
    FB.api "/me", (response) ->
      console.log response
      return
    return

  statusChangeCallback = (response) ->
    console.log "statusChangeCallback"
    {status, authResponse} = response
    console.log status
    if status is "connected"
      accessToken = authResponse.accessToken
      console.log accessToken
      # Logged into your app and Facebook.
      testAPI()
    else if status is "not_authorized"
      # The person is logged into Facebook, but not your app.
    else # unkown
      # The person is not logged into Facebook, so we're not sure if
      # they are logged into this app or not.
    return

  window.fbAsyncInit = ->
    FB.init
      appId: "109302492423481"
      cookie: true # enable cookies to allow the server to access the session?
      version: "v2.1" # use version 2.1
    FB.getLoginStatus statusChangeCallback
    return

  window.onload = -> # Attach event handlers.
    # Attach app to global window var as app.
    window.app =
      db: data # Our database.
    render = (Handler, props) ->
      React.render React.createElement(Handler, props), document
    App {}, render

module.exports = App
