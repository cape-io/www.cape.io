React = require 'react'
http = require 'superagent'

module.exports = React.createClass
  componentDidMount: ->
    app.me.logout()

  render: ->
    <p>You are now logged out</p>
