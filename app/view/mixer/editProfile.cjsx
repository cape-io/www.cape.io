React = require 'react'
t = require 'tcomb-form'
toTcomb = require 'tcomb-json-schema'
Menu = require '../menu'

Form = t.form.Form

module.exports = React.createClass
  getInitialState: ->
    editField: null

  handleChange: (newSt) ->
    @setState newSt

  editField: (fieldId) ->
    @setState editField: fieldId

  handleFieldSubmit: (fieldId, value) ->
    app.me.save fieldId, value

  handleSubmit: ->
    value = @refs.form.getValue()
    if value
      console.log value

  render: ->
    {user} = @props
    {fullName} = user

    profileSchema =
      type: 'object'
      properties:
        fullName:
          type: 'string'
        email:
          type: 'string'
      required: ['fullName', 'email']

    profileFieldOps =
      fullName:
        label: 'Full Name'
        help: 'Your full name as it will be displayed on your profile.'

    Profile = toTcomb(profileSchema)

    options =
      auto: 'labels'#placeholders
      fields: profileFieldOps

    if fullName
      titleEl = <h2 className="display-name">{fullName}</h2>

    <div className="row profile-edit">
      {titleEl}
      <Form ref="form" type={Profile} options={options} value={user} />
      <button onClick={@handleSubmit}>Submit</button>
    </div>
