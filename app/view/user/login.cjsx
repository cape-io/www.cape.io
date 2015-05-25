React = require 'react'
# {Transition} = require 'react-router'
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
    {email, emailStatus, passwordStatus} = @state
    {email_help, expired_account, title, lead} = @props
    lead = lead or 'You are great!'
    providerList = false

    if emailStatus is 'success'
      {fullName, expired, providers} = emailIndex[email]
      welcome = "Welcome, #{fullName}!"
      lead = welcome + ' ' + lead
      console.log welcome
      emailHelpTxt = false
      userInfo =
        <div>
          {if expired then <p>{expired_account}</p> else false}
        </div>
      if providers.length
        # Allow password?
        # Always allow email. Auto email login when that is the only option.
        providerList =
          <div className="login-links">
            <h3>Login With</h3>
            <ul>
              <li className="email"><a href="/user/email-token">Email</a> </li>
              {
                _.map providers, @providerLinks
              }
            </ul>
          </div>
    else
      userInfo = false
      emailHelpTxt = email_help

    <div className="row">
      <div className="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
        <h1> {title or 'Login'} </h1>
        <p className="lead">
          {lead or 'You are great!'}
        </p>


      </div>
    </div>
