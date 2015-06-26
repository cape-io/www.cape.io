React = require 'react'
Formsy = require 'formsy-react'
{Input} = require 'formsy-react-components'

module.exports = React.createClass
  getInitialState: ->
    canSubmit: false

  enableButton: ->
    @setState canSubmit: true
    return

  disableButton: ->
    @setState canSubmit: false
    return

  submit: (model) ->
    console.log model
    return

  render: ->
    {canSubmit} = @state
    <Formsy.Form onValidSubmit={@submit} onValid={@enableButton} onInvalid={@disableButton}>
      <Input name="email" validations="isEmail" validationError="This is not a valid email" label="Email" required/>
      <button type="submit" disabled={!canSubmit}>Submit</button>
    </Formsy.Form>
