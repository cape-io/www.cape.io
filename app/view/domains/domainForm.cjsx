React = require 'react'
{Input} = require 'react-bootstrap'

validator = require 'validator'

module.exports = React.createClass
  getInitialState: ->
    value: ""

  validationState: ->
    value = @state.value
    length = value.length
    isDomain = validator.isFQDN value
    if isDomain
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
      tld = subdomains.pop()
      domain = subdomains.pop()
      value = "#{domain}.#{tld}"
    @setState value: value
    return

  render: ->

    {value} = @state
    style = @validationState()

    <form>
      <Input
        type="text"
        value={value}
        placeholder="Enter text"
        label="Please enter your domain"
        help="Without http and without www please."
        bsStyle={style}
        hasFeedback
        ref="input"
        groupClassName="group-class"
        wrapperClassName="wrapper-class"
        labelClassName="label-class"
        onChange={@handleChange}
      />
    </form>
