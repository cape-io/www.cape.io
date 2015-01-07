React = require 'react'
{ListGroup, ListGroupItem} = require 'react-bootstrap'

module.exports = React.createClass
  render: ->
    {expires, dns} = @props.domain

    DnsList = for item, i in dns
      <ListGroupItem key={i}>{item}</ListGroupItem>
    <div className="domain-info">
      <h3>Expiration</h3>
      <p>{expires}</p>
      <h3>DNS Settings</h3>
      <ListGroup>
        {DnsList}
      </ListGroup>
    </div>
