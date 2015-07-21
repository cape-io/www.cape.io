React = require 'react'
Formsy = require 'formsy-react'
http = require 'superagent'
{Input, Textarea} = require 'formsy-react-components'

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
    data.siteId = 'cape'
    unless data.url
      delete data.url
    console.log data
    http.post('/api/contact').send(data).type('json').end (res) ->
      {badRequest, body} = res
      if res.badRequest
        alert(body?.message)
      else
        console.log body
        if body?.status is 'sent'
          alert("Sent email to #{body.email}. \n Confirmation: #{body._id}")
          resetForm()
        else
          alert('The message failed to send.')
    return

  render: ->
    {canSubmit} = @state
    <Formsy.Form onValidSubmit={@submit} onValid={@enableButton} onInvalid={@disableButton}>
      <div>Hello!</div>
      <Input name="name" validations={maxLength: 75, minLength: 3} validationError="Is this really your name?" label="Your Name" required/>
      <Input layout="elementOnly" name="url" className="hidden" validations="isEmptyString" validationError="This field is only for spam bots." label="Leave this URL field empty!" />
      <button type="submit" disabled={!canSubmit}>Submit</button>
    </Formsy.Form>
