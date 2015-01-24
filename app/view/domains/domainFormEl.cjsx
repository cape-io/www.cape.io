React = require 'react'
{Input, Row, Col} = require 'react-bootstrap'
{Navigation, State} = require 'react-router'

validator = require 'validator'

module.exports = React.createClass
  mixins: [Navigation, State]

  validationState: (value) ->
    {domains} = @props
    length = value.length
    unless length and length > 4
      return
    isDomain = validator.isFQDN value
    if isDomain and domains.get(value)
      "success"
    else if isDomain
      "warning"
    else "error"

  handleChange: (e) ->
    if e.preventDefault
      e.preventDefault()
    # This could be done using ReactLink:
    # http://facebook.github.io/react/docs/two-way-binding-helpers.html
    # However, we need custom editing of input.
    value = @refs.domain.getValue().toLowerCase()
    value = value.replace /^https?:\/\//, ''
    value = value.split('/')[0]
    subdomains = value.split('.')
    if subdomains.length > 3
      subdomains.shift()
      value = subdomains.join('.')
    @replaceWith @getPathname(), {}, {domain:value}
    #@setState value: value
    return

  render: ->
    {domains, value} = @props

    style = @validationState(value)

    <form onSubmit={@handleChange}>
      <Input
        type="text"
        value={value}
        placeholder="example.com"
        label="Please enter your domain"
        help="Without http or www please."
        bsStyle={style}
        hasFeedback
        ref="domain"
        groupClassName="group-class"
        wrapperClassName="wrapper-class"
        labelClassName="label-class"
        onChange={@handleChange}
      />
    </form>
