React = require 'react'

{ButtonToolbar, Button, Row, Col} = require 'react-bootstrap'

Credits   = require './credits'

module.exports = React.createClass
  getInitialState: ->
    name: null
    email: null
    facebook: false
    google: false

  fbSetName: ->
    FB.api '/me', (resp) =>
      {name, email} = resp
      @setState
        name: name
        email: email
        facebook: true

  fbClick: (e) ->
    FB.getLoginStatus (response) =>
      {status} = response
      if status is "connected"
        @fbSetName()
      else
        FB.login (resp) =>
          {authResponse} = resp
          if authResponse
            @fbSetName()

  googleClick: (e) ->
    return

  logout: ->
    FB.logout (resp) =>
      @setState facebook: false

  componentDidMount: ->
    #@fbClick()

  render: ->
    {data} = @props
    {title, tagline, since, builtDesigned} = data
    {facebook, google, name} = @state

    yr = new Date().getFullYear()
    msg = "\u00a9 Copyright #{since}-#{yr}, #{title}"

    unless facebook
      FbLogin = <Button onClick={@fbClick}>Facebook</Button>
    unless google
      GoogleLogin = <Button onClick={@googleClick}>Google</Button>

    if facebook or google
      Logout = <div className="disconnect">
        <h4>Logout</h4>
        <Button bsStyle="info" onClick={@logout}>Logout</Button>
      </div>

      if name
        loggedInText = "Logged in as #{name}"
        Name = <p>{loggedInText}</p>

    <footer>
      <div className="container">
        <Row>
          {Name}
          <Col sm={4} className="connect">
            <h4>Login</h4>
            <ButtonToolbar>
              {FbLogin}
              {GoogleLogin}
            </ButtonToolbar>
          </Col>
          {Logout}
          <Col sm={4} className="footer-credits">
            <Credits builtDesigned={builtDesigned} />
          </Col>
          <Col sm={4}>
            <p>{msg}</p>
          </Col>
        </Row>
      </div>
    </footer>
