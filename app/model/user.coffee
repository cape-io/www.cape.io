Model = require "ampersand-model"
http = require 'superagent'
Websites = require './websites'

module.exports = Model.extend
  url: '/user/me.json'
  session:
    isAuthenticated: ['boolean', true, false]
    tokenSent: ['boolean', false, false]
  props:
    id: 'string'
    email: 'string'
    fullName: 'string'
    providers: 'array'
    ids: 'array'
    fbConnected: 'bool'
  collections:
    websites: Websites
  extraProperties: 'allow'

  checkSession: ->
    http.get('/user/session.json')
    .accept('json')
    .end (err, res) =>
      if err
        return console.error err
      unless res?.body
        return console.error 'Session result is missing content.'
      {auth, creds, sess, user} = res.body
      info = creds or sess
      user = user or {}
      if auth and user
        user.isAuthenticated = true
        console.log 'User is authenticated.'
      if info?.id
        user.id = info.id
      if info?.email
        user.email = info.email
      if user.email
        unless @set @parse(user)
          console.error 'Unable to save user info.'
      # else
      #   console.log 'No user info.'
  logout: ->
    http.get('/user/logout').accept('json').end (err, res) =>
      if err
        return console.error err
      console.log 'logout', res
      @clear()
      # @TODO define other props to unset...

  requestToken: (cb) ->
    if @email
      console.log 'Token request.'
      http.get('/user/requestToken')
      .withCredentials()
      .accept('json')
      .end (err, res) =>
        if res.body.msgId
          @tokenSent = true
          cb(true)
        else
          console.error res.body
          cb(false)
      return
    else
      console.error 'No email!'
