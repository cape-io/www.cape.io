urlParser = require 'url'
crypto = require 'crypto'

generateSignUrl = (token, url) ->
  # parse url
  u = urlParser.parse(url, true, true)
  # Build the signing value
  signvalue = token + u.path
  # Calculate MD5 of the signing value.
  u.query.s = crypto.createHash("md5").update(signvalue).digest("hex")
  delete u.search
  #console.log u.query
  urlParser.format u

module.exports = (domain, token, sourceUrl, ops) ->
  u = urlParser.parse sourceUrl
  signedUrl =
    protocol: 'https'
    host: domain
    pathname: u.protocol+'//'+u.host+u.pathname
    query: ops
  if u.search
    signedUrl.pathname += encodeURIComponent u.search
  generateSignUrl token, urlParser.format(signedUrl)
