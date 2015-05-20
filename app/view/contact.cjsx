React = require 'react'

ContactForm = require './contactForm'

module.exports = React.createClass

  handleSubmit: (e) ->
    if e.preventDefault
      e.preventDefault()
    data =
      name: @refs.name.getDOMNode().value
      phoneNumber: @refs.phoneNumber.getDOMNode().value
      email: @refs.email.getDOMNode().value
      subject: @refs.subject.getDOMNode().value
      message: @refs.message.getDOMNode().value
      spam: @refs.spam.getDOMNode().value
    if data.spam
      console.log 'SPAM!' # Fake success message.
    else
      console.log data

  render: ->
    {contact, title} = @props
    unless contact
      return <span />
    {email, founded, location, phone} = contact
    if title
      titleEl = <span className="organization-name">{title}</span>

    # http://microformats.org/wiki/hcard
    if location
      {street, city, country, state, zip} = location
      addressEl =
        <div className="adr">
          <span className="street-address">{street}</span>
          <span className="locality">{city}</span>,
          <span className="region">{state}</span>
          <span className="postal-code">{zip}</span>
          <span className="country-name">{country}</span>
        </div>
    if phone
      telLink = "tel:+1#{phone.replace(/\D/g,'')}"
      phoneEl = <div className="tel">Tel: <a href={telLink}><span itemProp="telephone" className="value">{phone}</span></a></div>

    <section id="contact">
      <div className="inner">

        <div className="contact-details vcard">
          <span className="fn">{founded}</span><br />
          {titleEl}
          {addressEl}
          {phoneEl}
          <span className="email"><a href="mailto:info@loremipsum.com">{email}</a></span>
        </div>

        <ContactForm />

      </div>
    </section>
