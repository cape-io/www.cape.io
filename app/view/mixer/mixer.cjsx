React = require 'react'
{RouteHandler} = require 'react-router'
Menu = require '../menu'

module.exports = React.createClass
  statics:
    willTransitionTo: (transition, params) ->
      if typeof app is "undefined" or not app?.me?.isAuthenticated
        transition.redirect '/user/login/'

  render: ->
    {title, nav, user} = @props
    title = title or 'Mixer'
    nav = [
      {link:'mixer/profile', title:'Profile'}
      {link:'mixer/sites', title:'Websites'}
    ]

    <div className="group">
      <h1 className="twelve columns">{title}</h1>
      <Menu menu={nav} className="mixer-nav two columns" />
      <section className="ten columns">
        { React.createElement(RouteHandler, {user:user}) }
      </section>
    </div>
