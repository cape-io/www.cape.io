React = require 'react'
{Col} = require 'react-bootstrap'

DomainForm = require './domainForm'

module.exports = React.createClass
  render: ->

    {data} = @props

    <main className="row">
      <Col xs={6} xsOffset={3}>
        <h2>Renew your Domain</h2>
        <DomainForm />
      </Col>
    </main>
