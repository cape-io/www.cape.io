React = require 'react'

_ = require 'lodash'

# Text = require './el/text'
# TextArea = require './el/textarea'
# Select = require './el/select'
# SizeField = require './el/sizeField'
#ProfileImg = require './profile/profileImg'

module.exports = React.createClass

  #mixins: [React.addons.LinkedStateMixin]

  getInitialState: ->
    if @props.options and @props.options[0].value
      value: @props.value or @props.options[0].value
    else
      value: @props.value

  componentDidMount: ->
    @refs.fieldInput.getDOMNode().focus()

  setValue: (newVal) ->
    if @props.id == 'twitter'
      newVal = newVal.replace('@', '')
    @setState value: newVal

  handleSubmit: (e) ->
    e.preventDefault() # Prevent html form submit.
    # Save to model.
    val = @refs.fieldInput.getDOMNode().value or @state.value
    @props.onSubmit @props.id, val
    @props.editField null # Field isn't being edited.

  render: ->
    {id, help, placeholder, value, element, options} = @props
    formFieldProps =
      className: 'form-control input-md'
      value: @state.value
      ref: 'fieldInput'
      id: id
      placeholder: placeholder
      help: help
      fieldType: element
      options: options
      onChange: (e) =>
        @setValue e.target.value

    # if 'size' is id
    #   formFieldEl = SizeField formFieldProps
    # else if _.contains ['text', 'email'], element
    #   formFieldEl = input formFieldProps
    # else if field.element is 'select'
    #   formFieldEl = Select formFieldProps
    # else if field.element is 'textarea'
    #   formFieldEl = textarea formFieldProps
    formFieldEl = input formFieldProps
    # if id is 'pic'
    #   extraEl = ProfileImg
    #     model: @props.user
    #     setValue: @setValue
    #     value: @state.value
    # else
    extraEl = false

    <div className="eight columns form-inline editableform">
      {extraEl}
      <div className="editable-input">
        {formFieldEl}
        <span className="editable-clear-x" />
      </div>
      <div className="editable-buttons">
        <button
          className="btn btn-primary btn-sm editable-submit"
          type="submit"
          onClick={handleSubmit}
        >
          <i className="glyphicon glyphicon-ok" />
        </button>
        <button
          className="btn btn-default btn-sm editable-submit"
          onClick={editField(null)}
        >
          <i className="glyphicon glyphicon-remove" />
        </button>
      </div>
      <span className="help-block">
        {help}
      </span>
    </div>
