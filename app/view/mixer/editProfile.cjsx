React = require 'react'
t = require 'tcomb-form'
Menu = require '../menu'
{isEmail} = require 'validator'
Form = t.form.Form
Email = t.subtype t.Str, (s) ->
  isEmail s, {allow_utf8_local_part: false}

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
      app.me.save value

  render: ->
    {user} = @props
    {fullName} = user

    # profileSchema =
    #   type: 'object'
    #   properties:
    #     fullName:
    #       type: 'string'
    #     email:
    #       type: 'string'
    #   required: ['fullName', 'email']

    profileFieldOps =
      fullName:
        label: 'Full Name'
        help: 'Your full name as it will be displayed on your profile.'
      email:
        label: 'Primary Email'
        help: 'This is the email we will use to communicate with you.'
      bio:
        label: 'Brief Biography'
        type: 'textarea'
      statement:
        label: 'Artist Statement'
        help: 'The statement you want to accompany your work. *Italic* **Bold**.'
        type: 'textarea'
      # image

    Profile = t.struct {
      fullName: t.Str
      email: Email
      bio: t.Str
      statement: t.Str
    }
    options =
      legend: <h3>Profile Edit</h3>
      auto: 'labels'#placeholders
      fields: profileFieldOps

    if fullName
      titleEl = <h2 className="display-name">{fullName}</h2>

    <div className="profile-edit">
      {titleEl}
      <Form ref="form" type={Profile} options={options} value={user.toJSON()} />
      <button onClick={@handleSubmit}>Submit</button>
    </div>
