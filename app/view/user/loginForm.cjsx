React = require 'react'
# {Transition} = require 'react-router'
EmailForm = require './loginEmail'
_ = require 'lodash'
http = require 'superagent'
ProviderList = require './providerLinks'
emailIndex = {}

module.exports = React.createClass
  statics:
    willTransitionTo: (transition, params) ->
      if typeof app isnt "undefined" and app?.me?.isAuthenticated
        transition.redirect 'editProfile'

  contextTypes:
    router: React.PropTypes.func.isRequired

  getInitialState: ->
    email: if typeof app isnt "undefined" then app.me.email else ''
    emailStatus: null
    password: ''
    passwordStatus: null
    warningMsg: ''
    canSubmit: false

  handleMeChange: (usr, changedThing, more) ->
    if usr.isAuthenticated
      @context.router.transitionTo('editProfile')
    else if usr.email
      emailIndex[usr.email] = usr
      # If valid email and that is our only provider redirect.

      @setState {
        emailStatus: 'success'
        email: usr.email
      }

  componentDidMount: ->
    app.me.on 'change', @handleMeChange

  componentWillUnmount: ->
    app.me.off 'change', @handleMeChange

  onValidEmail: (userResObj) ->
    app.me.set userResObj
    console.log app.me.toJSON()
    app.me.requestToken (res) =>
      if res
        console.log 'token', res
        @context.router.transitionTo('checkEmail')
      else
        @context.router.transitionTo('loginFail')
      return
    @context.router.transitionTo('emailPending')

  changePass: ->
    pass = @refs.pass.getValue()
    @setState password: pass, passwordStatus: null

  handleSubmit: (e) ->
    e.preventDefault()
    # {email, password} = @state
    # {id} = emailIndex[email]
    # http.post('/user/login')
    #   .send({id: id, password: password})
    #   .accept('json')
    #   .end (err, res) =>
    #     console.error err if err
    #     if res.body
    #       app.me = res.body
    #       console.log res.body
    #     else
    #       console.log 'failed login'
    #       @setState passwordStatus: 'error'

  #mixins: [Navigation, CurrentPath]
  render: ->
    {email, emailStatus, passwordStatus, warningMsg, canSubmit} = @state
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
      providerList = <ProviderList providers={providers} />
    else
      userInfo = false
      if emailStatus is 'warning' and warningMsg
        lead = warningMsg
      else
        lead = "Enter your email to start the login process."

    <div className="login-form">
      <EmailForm onValidEmail={@onValidEmail} email={email} />
    </div>
