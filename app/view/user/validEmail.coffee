_ = require 'lodash'
http = require 'superagent'
emailIndex = {}

isValidEmail = (email, setMe, cb) ->
  unless email
    return false

  unless emailIndex[email]
    emailIndex[email] = {email: email}

  status = (code, msg) ->
    emailIndex[email].success = code is true
    emailIndex[email].code = if code is true then 'success' else code
    emailIndex[email].msg = msg
    if cb
      return cb emailIndex[email]
    return emailIndex[email]

  # Check our app memory cache for known invalid emails.
  if emailIndex[email].success is false
    return emailIndex[email]
  # Known valid email address.
  else if emailIndex[email].success
    if app.me.email isnt email and setMe
      app.me.set(emailIndex[email])
    return emailIndex[email]

  # Previously unknown value in the email field.
  unless _.contains(email, '@')
    return status('no-at', 'The email must contain an "@" symbol.')
  unless domain = email.split('@')[1]
    return status('no-domain', 'Please include a valid domain for your email.')
  unless _.contains(domain, '.') and tld = domain.split('.')[1]
    return status('no-tld', 'The domain part of your email is not complete.')
  unless tld.length > 1
    return status('invalid-ltd', 'The email domain is too short.')

  #console.log 'Checking email ', email
  http.get('/user/email/'+email)
  .withCredentials()
  .accept('json').end (err, res) =>
    if err
      console.error err, res
      unless navigator.onLine
        alert 'Please check your internet connection and try again.'
      else
        console.log 'maybe the server is down?'
        # @TODO send a notice to hipchat or email or SMS of error.
    else if res
      if res.badRequest
        status('warning', res.body.message)
      else if res.body
        if res.body[0]
          emailIndex[email] = res.body[0]
          return status(true)
        else
          status('warning', "We could not find #{email} in our database of users.")
  unless cb
    return status('pending')
module.exports = isValidEmail
