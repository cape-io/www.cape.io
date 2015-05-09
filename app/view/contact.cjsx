React = require 'react'

module.exports = React.createClass
  render: ->
    {contact, title} = @props
    unless contact
      return <span />
    {email, founded, location, phone} = contact
    if title
      titleEl = <span class="organization-name">{title}</span>

    # http://microformats.org/wiki/hcard
    if location
      {street, city, country, state, zip} = location
      addressEl =
        <div class="adr">
          <span class="street-address">{street}</span>
          <span class="locality">{city}</span>,
          <span class="region">{state}</span> <br />
          <span class="postal-code">{zip}</span>
          <span class="country-name">{country}</span>
        </div>
    if phone
      telLink = "tel:+1#{phone.replace(/\D/g,'')}"
      phoneEl = <div className="tel">Tel: <a href={telLink}><span itemprop="telephone" class="value">{phone}</span></a></div>

    <section id="contact">
      <div className="inner">

        <div className="contact-details vcard">
          <span class="fn">{founded}</span><br />
          {titleEl}
          {addressEl}
          {phoneEl}
          <span class="email"><a href="mailto:info@loremipsum.com">{email}</a></span>
        </div>

        <form className="form-style validate-form clearfix" action="/forms/contact" method="POST" role="form">
          <div className="fields">
            <input type="text" className="text-field form-control validate-field required" id="form-name" placeholder="Full Name" name="name" />
            <input type="email" className="text-field form-control validate-field required" id="form-email" placeholder="Email Address" name="email" />
            <input type="subject" className="text-field form-control validate-field phone" id="form-contact-subject" placeholder="Subject" name="subject" />
          </div>
          <div className="message">
            <textarea placeholder="Message..." className="form-control validate-field required" name="message"></textarea>
            <input type="text" className="text-field form-control validate-field required" id="form-url" placeholder="URL" name="url" />
            <button type="submit" className="btn btn-sm btn-outline-inverse">Submit</button>
          </div>
        </form>

      </div>
    </section>
