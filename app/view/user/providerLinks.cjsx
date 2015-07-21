React = require 'react'
_ = require 'lodash'

module.exports = React.createClass
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
    {providers} = @props

    if providers.length
      # Allow password?
      # Always allow email. Auto email login when that is the only option.
      providerList = _.map providers, @providerLinks

    <div className="login-links">
      <h3>Login With</h3>
      <ul>
        <li className="email"><a href="/user/email-token">Email</a> </li>
        { providerList }
      </ul>
    </div>
