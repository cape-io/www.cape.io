React = require 'react'
{Row, Col} = require 'react-bootstrap'

module.exports = React.createClass
  render: ->

    {domains} = @props.data

    <main className="container">
      <Row>
        <h2>Getting Started</h2>
        <p>Enter your Facebook page id.</p>
      </Row>
    </main>
