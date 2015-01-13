React = require 'react'

{Jumbotron} = require 'react-bootstrap'

module.exports = React.createClass
  render: ->
    {lead, data} = @props
    {title, tagline} = data

    <Jumbotron id="hero">
      <h1>{title}<small>{tagline}</small></h1>
      <p>{lead}</p>
    </Jumbotron>
