React = require 'react'

module.exports = React.createClass
  render: ->
    <section id="contact">
      <div className="inner">

        <div className="contact-details">
          <address>1234 Aldrich Ave. So.,<br />Minneapolis, MN<br />55419</address>
          <p>Tel: (612) 555-1234</p>
          <p><a href="mailto:info@loremipsum.com">info@loremipsum.com</a></p>
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
