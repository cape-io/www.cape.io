React = require 'react'
Formsy = require 'formsy-react'
ComponentMixin = require './mixins/component'
Row = require('./row')
Icon = require('./icon')

module.exports = React.createClass
  mixins: [
    Formsy.Mixin
    ComponentMixin
  ]
  propTypes: type: React.PropTypes.oneOf([
    'color'
    'date'
    'datetime'
    'datetime-local'
    'email'
    'hidden'
    'month'
    'number'
    'password'
    'range'
    'search'
    'tel'
    'text'
    'time'
    'url'
    'week'
  ])

  getDefaultProps: ->
    { type: 'text' }

  changeValue: (event) ->
    value = event.currentTarget.value
    @_changeValue value

  _changeValue: (newVal) ->
    {name, onChange} = @props
    oldVal = @getValue()
    unless oldVal is newVal
      @setValue newVal
      onChange name, newVal
    return

  lookForChanges: ->
    {name} = @props
    fieldVal = @refs[name].getDOMNode().value
    unless fieldVal
      return
    @_changeValue fieldVal

  componentDidMount: ->
    pauseBetweenCheck = 250#ms
    @interval = setInterval @lookForChanges, pauseBetweenCheck

  componentWillUnmount: ->
    clearInterval @interval

  renderElement: ->
    {type, disabled, name} = @props

    className = 'form-control'
    if [ 'range' ].indexOf(type) != -1
      className = null
    <input
      ref={name}
      className={className}
      {...this.props}
      id={this.getId()}
      label={null}
      value={this.getValue()}
      onChange={@changeValue}
      disabled={@isFormDisabled() || disabled}
      onBlur={@changeValue}
    />


  render: ->
    {type, label} = @props
    element = @renderElement()
    if @getLayout() == 'elementOnly' or type == 'hidden'
      return element
    warningIcon = ''
    if @showErrors()
      warningIcon = <Icon symbol="remove" className="form-control-feedback" />

    <Row
      label={label}
      required={this.isRequired()}
      hasErrors={this.showErrors()}
      layout={this.getLayout()}
      htmlFor={this.getId()}
    >
      {element}
      {warningIcon}
      {this.renderHelp()}
      {this.renderErrorMessage()}
    </Row>
