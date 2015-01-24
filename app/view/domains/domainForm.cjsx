React = require 'react'
{Input, Row, Col} = require 'react-bootstrap'
{Navigation, State} = require 'react-router'

validator = require 'validator'

DomainFormEl = require './domainFormEl'
Domain = require './domain'
Renew = require './renew'

module.exports = React.createClass
  mixins: [Navigation, State]

  getDomainValue: ->
    q = @getQuery() or {}
    if @isMounted() then q.domain else ''

  componentDidMount: ->
    if @getQuery().domain
      @forceUpdate()

  render: ->
    {domains} = @props
    value = @getDomainValue()

    if value and domain = domains.get(value)
      DomainInfo = <Domain domain={domain}  />
      DomainRenew = <Renew model={domain} domain={value} />

    <div className="domain-search">
      <DomainFormEl domains={domains} value={value} />
      <Row>
        <Col xs={8} md={8}>{DomainRenew}</Col>
        <Col xs={4} md={4}>{DomainInfo}</Col>
      </Row>
    </div>
