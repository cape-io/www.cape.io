React = require 'react'
Formsy = require 'formsy-react'

validEmail = require './validEmail'

module.exports = React.createClass
  mixins: [Formsy.Mixin]
  getInitialState: ->
    value: ''
    helpTxt: ''

  changeValue: (event) ->
    val = event.currentTarget.value
    status = validEmail val
    @setState
      value: val
      helpTxt: if status.success then '' else status.msg
    console.log status
    #@setValue(val)

  renderElement: ->
    className = 'form-control'
    <input
      className={className}
      {...@props}
      id={@getId()}
      label={null}
      value={@getValue()}
      onChange={@changeValue}
      disabled={@isFormDisabled() || @props.disabled}
    />

  validate: () ->
    val = @getValue()
    valid = validEmail val
    unless valid
      return false
    console.log valid
    if val and val.length > 4 then true else false

  render: ->
    {name, label} = @props
    {value, helpTxt} = @state

    className = @props.className + ' ' + (@showRequired() ? 'required' : this.showError() ? 'error' : null)
    if errorMsg = @getErrorMessage()
      messageEl = <span className="validation-error">{errorMsg}</span>
    else if helpTxt
      messageEl = <span className="help-text">{helpTxt}</span>

    <div className='form-group'>
      <label htmlFor={name}>{label}</label>
      <input type="email" ref="email2" name={name} onChange={@changeValue} onBlur={@changeValue} value={value}/>
      <span className="help-text">{helpTxt}</span>
    </div>
