React = require 'react'
# {Transition} = require 'react-router'
{Input} = require 'react-bootstrap'
_ = require 'lodash'
http = require 'superagent'
emailIndex = {}

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  getInitialState: ->
    email: ''
    emailStatus: null
    password: ''
    passwordStatus: null
    providers: []

  componentDidMount: ->
    http.get('/user/session.json')
    .accept('json')
    .end (err, res) =>
      if info = res?.body
        if info.auth
          console.log 'authenticated'
        else if app.me = info.user
          if app.me.providers
            emailIndex[app.me.email] = app.me
            @setState {
              email: app.me.email
              emailStatus: 'success'
              providers: app.me.providers
            }

  changeEmail: ->
    email = @refs.email.getValue()
    if emailIndex[email] is false
      @setState
        emailStatus: 'error'
        email: email
      return
    if emailIndex[email]
      @setState
        emailStatus: 'success'
        email: email
      return
    if _.contains(email, '@') and domain = email.split('@')[1]
      if _.contains(domain, '.') and tld = domain.split('.')[1]
        if tld.length > 1
          #console.log 'Checking email ', email
          http.get('/user/email/'+email)
          .withCredentials()
          .accept('json').end (err, res) =>
            if not err and res and res.body
              if emailIndex[email] = res.body[0] or false
                @setState emailStatus: 'success'
              else
                @setState emailStatus: 'warning'
            else
              console.log err, res
    @setState
      emailStatus: null
      email: email

  changePass: ->
    pass = @refs.pass.getValue()
    @setState password: pass, passwordStatus: null

  handleSubmit: (e) ->
    e.preventDefault()
    {email, password} = @state
    {id} = emailIndex[email]
    http.post('/user/login')
      .send({id: id, password: password})
      .accept('json')
      .end (err, res) =>
        console.error err if err
        if res.body
          app.me = res.body
          console.log res.body
        else
          console.log 'failed login'
          @setState passwordStatus: 'error'

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
      return <li key={id}><a href={link} title={msg}>{id}</a></li>
    return false

  #mixins: [Navigation, CurrentPath]
  render: ->
    {email, emailStatus, passwordStatus, providers} = @state
    {email_help, expired_account, title, lead} = @props
    lead = lead or 'You are great!'
    providerList = false
    if emailStatus is 'success'
      {fullName, expired} = emailIndex[email]
      welcome = "Welcome, #{fullName}!"
      lead = welcome + ' ' + lead
      console.log welcome
      emailHelpTxt = false
      userInfo =
        <div>
          {if expired then <p>{expired_account}</p> else false}
        </div>
      if providers.length
        providerList =
          <ul>
            {
              _.map providers, @providerLinks
            }
          </ul>
    else
      userInfo = false
      emailHelpTxt = email_help

    <div className="row">
      <div className="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
        <h1> {title or 'Login'} </h1>
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
    </div>
