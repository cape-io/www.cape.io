React = require 'react'
{Row, Col} = require 'react-bootstrap'
{Navigation, State} = require 'react-router'

DomainForm = require '../domains/domainFormEl'
ClaimForm = require './claimForm'

module.exports = React.createClass
  mixins: [Navigation, State]
  getDomainValue: ->
    q = @getQuery() or {}
    if @isMounted() then q.domain else ''

  componentDidMount: ->
    if @getQuery().domain
      @forceUpdate()

  render: ->
    {domains} = @props.data
    value = @getDomainValue()

    if value and domain = domains.get(value)
      ClaimEl = <ClaimForm model={domain} domain={value} />

    <main className="container">
      <Row>
        <Col md={10} xsOffset={1}>
          <h2>Claim Your Website</h2>
          <DomainForm domains={domains} value={value} />
        </Col>
      </Row>
      {ClaimEl}
    </main>
