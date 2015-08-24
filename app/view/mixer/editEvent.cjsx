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

  render: ->
    {event} = @props
    {disabled} = @state

    help =
      body: 'The description you want to accompany your event. *Italic* **Bold**.'
    # If enter a url and it pulls from elsewhere we need to make filled in fields fixed.
    # url, title, category, date, timeEnd, timeStart, allDay, photo, description, price, urlTicket
    <div className="profile-edit">
      {titleEl}
      <Formsy.Form onValidSubmit={@handleSubmit} onValid={@enableButton} onInvalid={@disableButton}>
        <Input name="url" label="URL"
          validations={minLength: 12, maxLength: 750}
          validationError="Valid URL please. Include http(s)://" required
        />
        <Input name="urlTicket" label="Ticket URL"
          validations={minLength: 12, maxLength: 750}
          validationError="Valid URL please. Include http(s)://"
        />
        <Input name="email" vlabel="Event Email"
          validations="isEmail" validationError="This is not a valid email"
        />
        <Input name="phone" label="Event Phone"
          validations={maxLength: 20} validationError="That doesn't look right."
        />
        <Input name="price" label="Price"
          validations="isNumeric" validationError="That doesn't look right."
        />
        <Photo name="photo" value={photo} metadata={imgType: 'event'} />
        <Textarea name="body" label="Description"
          validations={maxLength: 50000} validationError="Too much text..."
          value={statement} help={help.body}
        />
        <button type="submit" disabled={disabled}>Submit</button>
      </Formsy.Form>
    </div>
