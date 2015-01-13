React = require 'react'
{Col} = require 'react-bootstrap'

DomainForm = require './domainForm'

module.exports = React.createClass
  render: ->

    {domains} = @props.data

    <main className="row">
      <Col md={10} xsOffset={1}>
        <h2>Renew your Domain</h2>
        <DomainForm domains={domains} />
      </Col>
    </main>
