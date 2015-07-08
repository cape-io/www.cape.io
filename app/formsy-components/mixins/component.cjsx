'use strict'
React = require('react')

module.exports =
  propTypes: layout: React.PropTypes.string
  contextTypes: layout: React.PropTypes.string

  getDefaultProps: ->
    {
      disabled: false
      validatePristine: false
      onChange: ->
      onFocus: ->
      onBlur: ->

    }

  hashString: (string) ->
    hash = 0
    i = 0
    while i < string.length
      hash = (hash << 5) - hash + string.charCodeAt(i) & 0xFFFFFFFF
      i++
    hash

  getId: ->
    @props.id or @props.name.split('[').join('_').replace(']', '') + @hashString(JSON.stringify(@props))

  getLayout: ->
    defaultLayout = @context.layout or 'horizontal'
    if @props.layout then @props.layout else defaultLayout

  renderHelp: ->
    if !@props.help
      return ''
    <span className="help-block">{this.props.help}</span>

  renderErrorMessage: ->
    if !@showErrors()
      return ''
    errorMessage = @getErrorMessage()
    if !errorMessage
      return ''
    <span className="help-block validation-message">{errorMessage}</span>

  showErrors: ->
    if @isPristine() == true
      if @props.validatePristine == false
        return false
    @isValid() == false
