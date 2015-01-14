React = require 'react'

{Jumbotron} = require 'react-bootstrap'

module.exports = React.createClass
  render: ->
    {lead, data} = @props
    {title, tagline} = data

    <Jumbotron id="hero">
      <div className="grouped">
        <h1>{title}</h1>
        <h2>{tagline}</h2>
        <p>{lead}</p>
      </div>
    </Jumbotron>
