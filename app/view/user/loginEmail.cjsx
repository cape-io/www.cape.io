React = require 'react'
# {Transition} = require 'react-router'
Formsy = require 'formsy-react'
Input = require '../../formsy-components/input'

validEmail = require './validEmail'

# Handle the email input first.
module.exports = React.createClass
  getInitialState: ->
    canSubmit: false

  enableButton: ->
    @setState canSubmit: true
    return

  disableButton: ->
    @setState canSubmit: false
    return

  submit: (data, resetForm, invalidateForm) ->
    {onValidEmail} = @props
    validEmail data.email, false, (res) ->
      console.log res
      if res.code is 'success'
        resetForm({email: ''})
        onValidEmail(res)
      else
        invalidateForm(email: res.msg)
    return false

  # onInvalidSubmit: (data, resetForm, invalidateForm) ->
  #   console.log data

  onSubmit: (e) ->
    e.preventDefault()
    return

  render: ->
    {canSubmit} = @state
    {email} = @props
    disabled = !canSubmit
    lead = "Enter your email to start the login process."
    <Formsy.Form onValidSubmit={@submit} onValid={@enableButton} onInvalid={@disableButton}>
      <div>{lead}</div>
      <Input name="email" validations="isEmail" validationError="This is not a valid email yet." label="Email:" required placeholder="Enter your email" value={email} />
      <Input name="url" layout="elementOnly" className="hidden" validations="isEmptyString" validationError="This field is only for spam bots." label="Leave this URL field empty!" value=""/>
      <button type="submit" disabled={disabled} onSubmit={@onSubmit}>Submit</button>
    </Formsy.Form>
