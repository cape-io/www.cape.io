React = require 'react'

module.exports = React.createClass
  render: ->
    {lead, title, tagline} = @props

    <div id="hero", className="jumbotron">
      <div className="grouped">
        <h1>{title}</h1>
        <h2 className="tagline">{tagline}</h2>
        <p className="lead">{lead}</p>
      </div>
    </div>
