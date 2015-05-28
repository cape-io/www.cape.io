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

  getInitialState: ->
    email: ''
    emailStatus: null
    password: ''
    passwordStatus: null

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

  # User has made a change to the email address field.
  changeEmail: ->
    email = @refs.email.getValue()
    # Check our app memory cache for known invalid emails.
    if emailIndex[email] is false
      @setState
        emailStatus: 'error'
        email: email
      return
    # Known valid email address.
    if emailIndex[email]
      app.me.set(emailIndex[email])
      return

    # Previously unknown value in the email field.
    if _.contains(email, '@') and domain = email.split('@')[1]
      if _.contains(domain, '.') and tld = domain.split('.')[1]
        if tld.length > 1
          #console.log 'Checking email ', email
          http.get('/user/email/'+email)
          .withCredentials()
          .accept('json').end (err, res) =>
            if not err and res and res.body
              emailIndex[email] = res.body[0] or false
              if emailIndex[email]
                app.me.set(emailIndex[email])
              else
                @setState emailStatus: 'warning'
            else
              console.error err, res
              if navigator.onLine
                alert 'Please check your internet connection and try again.'
              else
                # @TODO send a notice to hipchat or email or SMS of error.

    @setState
      emailStatus: null
      email: email

  clickEmail: ->
    app.me.requestToken (res) =>
      if res
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

  providerLinks: (id) ->
    {pass_help, pass_link} = @props
    if id is 'password'
      passHelpTxt =
        <div>{pass_help+' '}<a href="#">{pass_link}</a></div>
      passwordField =
        <li key={id}>
          <Input
            type="password"
            ref="pass"
            label="Password:"
            help={passHelpTxt}
            onChange={@changePass}
            bsStyle={passwordStatus}
          />
          <Input type="submit" value="Login" />
        </li>
      return passwordField

    providerIndex =
      google: '/user/login/google'
      twitter: '/user/login/twitter'
      facebook: '/user/login/facebook'
      github: '/user/login/github'
      instagram: '/user/login/instagram'
    if link = providerIndex[id]
      msg = "Login with #{id}."
      return <li key={id} className={id}><a href={link} title={msg}>{_.capitalize(id)}</a></li>
    return false

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

    <div className="login-form">
      <p className="lead">
        {lead or 'You are great!'}
      </p>
      <form onSubmit={@handleSubmit}>
        <Input
          type="text"
          value={email}
          placeholder='Enter your email'
          label='Your email please:'
          help={emailHelpTxt}
          bsStyle={emailStatus}
          ref='email'
          hasFeedback= {true}
          groupClassName='group-class-login'
          wrapperClassName='wrapper-class-login'
          labelClassName='label-class-editable'
          onChange={@changeEmail}
        />
        {userInfo}
        {providerList}
      </form>
    </div>
