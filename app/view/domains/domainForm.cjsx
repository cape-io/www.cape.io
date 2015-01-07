React = require 'react'
{Input} = require 'react-bootstrap'

validator = require 'validator'

Domain = require './domain'

module.exports = React.createClass
  getInitialState: ->
    value: ""

  validationState: ->
    {domains} = @props
    value = @state.value
    length = value.length
    isDomain = validator.isFQDN value
    if length
      if isDomain and domains[value]
        "success"
      else if length < 5
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

    if value and domain = domains[value]
      DomainInfo = <Domain domain={domain} />

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
      {DomainInfo}
    </div>
