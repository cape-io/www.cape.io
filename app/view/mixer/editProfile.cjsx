React = require 'react'
Formsy = require 'formsy-react'
Input = require '../../formsy-components/input'
{Textarea} = require 'formsy-react-components'
Photo = require '../imageUpload/photo'

Menu = require '../menu'

module.exports = React.createClass
  getInitialState: ->
    editField: null
    disabled: true

  handleChange: (newSt) ->
    @setState newSt

  editField: (fieldId) ->
    @setState editField: fieldId

  enableButton: ->
    @setState disabled: false
    return

  disableButton: ->
    @setState disabled: true
    return

  # handleFieldSubmit: (fieldId, value) ->
  #   app.me.save fieldId, value

  handleSubmit: (value, resetForm, invalidateForm) ->
    # value = @refs.form.getValue()
    console.log 'submit', value
    if value
      app.me.save value

  render: ->
    {user} = @props
    {disabled} = @state
    {fullName, email, bio, statement, photo} = user

    if fullName
      titleEl = <h2 className="display-name">{fullName}</h2>
    else
      titleEl = <h2>Profile Edit</h2>

    help =
      name: 'Your full name as it will be displayed on your profile.'
      email: 'This is the email we will use to communicate with you.'
      bio: 'Please keep to less than 200 words.'
      statement: 'The statement you want to accompany your work. *Italic* **Bold**.'

    <div className="profile-edit">
      {titleEl}
      <Formsy.Form onValidSubmit={@handleSubmit} onValid={@enableButton} onInvalid={@disableButton}>
        <Input name="email" validations="isEmail"
          validationError="This is not a valid email yet." label="Email:" required
          placeholder="Enter your email" value={email} help={help.email}
        />
        <Photo name="photo" value={photo} metadata={imgType: 'profile', title: 'Profile Picture'}/>
        <Input name="fullName" validations={maxLength: 75, minLength: 3}
          validationError="Is this really your name?" label="Your Full Name" required
          value={fullName} help={help.name}
        />
        <Textarea name="bio" label="Brief Biography" validations={maxLength: 25000}
          validationError="Too much text..." value={bio} help={help.bio}
        />
        <Textarea name="statement" label="Artist Statement"
          validations={maxLength: 50000} validationError="Too much text..."
          value={statement} help={help.statement}
        />
        <button type="submit" disabled={disabled}>Submit</button>
      </Formsy.Form>
    </div>
