React = require 'react'

module.exports = React.createClass

  propTypes:
    id: React.PropTypes.string.isRequired
    label: React.PropTypes.string.isRequired
    fieldType: React.PropTypes.string.isRequired
    placeholder: React.PropTypes.string

  render: ->
    {label, id, value, onChange, type, placeholder, help} = @props

    <div className="form-group">
      <label className="two columns control-label" htmlFor={id}>
        {label}
      </label>
      <div className="eight columns">
        <input
          className="form-control"
          id={id}
          value={value}
          onChange={onChange}
          type={fieldType}
          placeholder={placeholder}
        />
        <span className="help-block">
          {help}
        </span>
      </div>
    </div>
