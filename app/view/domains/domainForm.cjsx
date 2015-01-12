React = require 'react'
{Input, Row, Col} = require 'react-bootstrap'

validator = require 'validator'

Domain = require './domain'
Renew = require './renew'

module.exports = React.createClass
  getInitialState: ->
    value: ""

  validationState: ->
    {domains} = @props
    value = @state.value
    length = value.length
    isDomain = validator.isFQDN value
    if length > 5
      if isDomain and domains.get(value)
        "success"
      else if isDomain
        "warning"
      else "error"

  handleChange: ->
    # This could be done using ReactLink:
    # http://facebook.github.io/react/docs/two-way-binding-helpers.html
    # However, we need custom editing of input.
    value = @refs.input.getValue().replace /^https?:\/\//, ''
    value = value.split('/')[0]
    subdomains = value.split('.')
    if subdomains.length > 3
      subdomains.shift()
      value = subdomains.join('.')
    @setState value: value
    return

  render: ->
    {domains} = @props
    {value} = @state

    style = @validationState()

    if value and domain = domains.get(value)
      DomainInfo = <Domain domain={domain}  />
      DomainRenew = <Renew model={domain} domain={value} />

    <div className="domain-search">
      <form>
        <Input
          type="text"
          value={value}
          placeholder="example.com"
          label="Please enter your domain"
          help="Without http or www please."
          bsStyle={style}
          hasFeedback
          ref="input"
          groupClassName="group-class"
          wrapperClassName="wrapper-class"
          labelClassName="label-class"
          onChange={@handleChange}
        />
      </form>
      <Row>
        <Col xs={8} md={8}>{DomainRenew}</Col>
        <Col xs={4} md={4}>{DomainInfo}</Col>
      </Row>
    </div>
