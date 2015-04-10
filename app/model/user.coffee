Model = require "ampersand-model"
http = require 'superagent'
Websites = require './websites'

module.exports = Model.extend
  url: '/user/me.json'
  session:
    isAuthenticated: ['boolean', true, false],
  props:
    id: 'string'
    email: 'string'
    fullName: 'string'
    providers: 'array'
    ids: 'array'
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
