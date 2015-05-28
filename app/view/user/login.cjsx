React = require 'react'
{RouteHandler} = require 'react-router'
{Input} = require 'react-bootstrap'
_ = require 'lodash'
http = require 'superagent'
emailIndex = {}

module.exports = React.createClass
  statics:
    willTransitionTo: (transition, params) ->
      if typeof app isnt "undefined" and app?.me?.isAuthenticated
        transition.redirect 'editProfile'

  contextTypes:
    router: React.PropTypes.func.isRequired

  #mixins: [Navigation, CurrentPath]
  render: ->
    {title} = @props

    <div className="row">
      <div className="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
        <h1> {title or 'Login'} </h1>
        { React.createElement(RouteHandler, @props) }
      </div>
    </div>
