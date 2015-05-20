React = require 'react'
_ = require 'lodash'
http = require 'superagent'
emailIndex = {}

module.exports = React.createClass

  getInitialState: ->
    formStatus: {}
    email: ''
    emailStatus: null

  handleSubmit: (e) ->
    if e.preventDefault
      e.preventDefault()
    data =

    if data.spam
      console.log 'SPAM!'
    else
      console.log data

  formValues: ->
    name: @refs.name.getDOMNode().value
    phoneNumber: @refs.phoneNumber.getDOMNode().value
    email: @refs.email.getDOMNode().value
    subject: @refs.subject.getDOMNode().value
    message: @refs.message.getDOMNode().value
    spam: @refs.spam.getDOMNode().value

  validateForm: ->
    vals = @formValues
    valid =
      name: vals.name and vals.name.length > 2
      email: emailIndex[vals.email]
      subject: vals.subject and vals.subject.length > 2
      message: vals.message and vals.message.length > 8
      spam: vals.spam

  emailChange: (email) ->
    email = @refs['email'].getDOMNode().value
    emailStatus = null
    if emailIndex[email] is false
      @setState
        emailStatus: 'has-error'
        email: email
      return
    if emailIndex[email]
      @setState
        emailStatus: 'has-success'
        email: email
      return

    if _.contains(email, '@') and domain = email.split('@')[1]
      if _.contains(domain, '.') and tld = domain.split('.')[1]
        if tld.length > 1
          http.get('/emailCheck/'+email)
          .withCredentials()
          .accept('json').end (err, res) =>
            if not err and res and res.body
              if res.body.valid
                emailIndex[email] = true
                emailStatus = 'has-success'
              else
                emailIndex[email] = false
                emailStatus = 'has-error'
              @setState
                emailStatus: emailStatus
                email: email
            else
              console.error err, res
          return

    emailIndex[email] = false
    @setState
      emailStatus: emailStatus
      email: email

  render: ->
    {emailStatus, email} = @state
    if emailStatus is 'has-success'
      feedback = "glyphicon-ok"
    else if emailStatus is 'has-error'
      feedback = "glyphicon-remove"

    <form className="form-style validate-form clearfix" action="/forms/contact" method="POST" role="form" onSubmit={@handleSubmit}>
      <div className="fields">
        <div className="form-group has-success">
          <input type="text" className="text-field form-control validate-field required"
            id="form-name" placeholder="Full Name (required)" name="name"
            ref="name" required
          />
        </div>

        <div className={"form-group #{emailStatus}"}>
          <label className="control-label label-class-editable">Your email please:</label>
          <span>{feedback}</span>
          <input type="email" className="text-field form-control validate-field required"
            id="form-email" placeholder="Email Address (required)" name="email" ref="email"
            onChange={@emailChange} onBlur={@emailChange} value={email} required
          />
          <span className={"glyphicon form-control-feedback #{feedback}"}></span>
        </div>

        <div className="form-group has-success">
          <input type="phone" className="text-field form-control validate-field required"
            id="form-phone" placeholder="Phone Number" name="phone" ref="phoneNumber"
          />
        </div>
        <div className="form-group has-success">
          <input type="subject" className="text-field form-control validate-field phone"
            id="form-contact-subject" placeholder="Subject (required)" name="subject"
            ref="subject" required
          />
        </div>
      </div>
      <div className="message">
        <textarea placeholder="Message... (required)" className="form-control validate-field required" name="message" ref="message"></textarea>
        <div className="form-group">
          <label className="control-label label-class-editable">Leave this field blank!</label>
          <input type="text" className="text-field form-control validate-field required" id="form-url" placeholder="URL" name="url" ref="spam" />
        </div>
        <button type="submit" className="btn btn-sm btn-outline-inverse" onClick={@handleSubmit}>Submit</button>
      </div>
    </form>
