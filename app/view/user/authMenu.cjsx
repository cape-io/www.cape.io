React = require 'react'
Menu = require '../menu'

module.exports = React.createClass
  getInitialState: ->
    isAuthenticated: typeof app isnt "undefined" and app?.me?.isAuthenticated

  handleMeChange: (usr, changedThing, more) ->
    unless @state.isAuthenticated is usr.isAuthenticated
      @setState isAuthenticated: usr.isAuthenticated

  componentDidMount: ->
    app.me.on 'change', @handleMeChange

  componentWillUnmount: ->
    app.me.off 'change', @handleMeChange

  render: ->
    {isAuthenticated} = @state
    if isAuthenticated
      links = [
        {link: 'mixer/profile/', title: 'Edit Profile'}
        {link: 'user/logout/', title: 'Logout'}
      ]
    else
      links = [{to: 'login', title: 'Login'}]

    <Menu menu={links} title="User Menu" />
