React = require 'react'
cx = require 'react/lib/cx'
_ = require 'lodash'
md = require 'marked'

EditField = require './editField'

module.exports = React.createClass

  render: ->
    {id, editable, value, label, editField, editing, options, element, model} = @props

    # Determine if field is editable.
    fieldIsEditable = editable isnt false

    # Assign value to fieldValue variable.
    fieldValue = value
    if fieldValue
      if options
        if val = _.find(options, value: fieldValue)
          fieldValue = val.name
      if element is 'textarea'
        fieldValue =
          <span className="markdown"
            dangerouslySetInnerHTML={__html: md(fieldValue)}
          />
      if id is 'pic'
        fieldValue = <img src={fieldValue} alt="Picture" />
      else if id is 'size'
        fieldValue = model.sizeDisplay
    else
      fieldValue = 'Empty'

    # Calculate classes for the value Element.
    buttonClasses = cx
      'col-md-8': true
      'form-value': true
      'editable-click': fieldIsEditable
      'required': @props.required
      'editable-empty': !@props.value

    # Value element.
    if fieldIsEditable
      if editing
        valueEl = EditField @props
      else
        valueEl =
          <button onClick={-> editField(id)} className={buttonClasses}>
            {fieldValue}
          </button>
    else # Fixed value.
      valueEl = <div className={buttonClasses}>{fieldValue}</div>

    rowClasses = cx
      'editable': fieldIsEditable
      'form-group': true

    # RENDER
    <div id={id} className={rowClasses}>
      <div className"two columns text-right">
        {label}
        {valueEl}
      </div>
    </div>
