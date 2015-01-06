r = require 'request'

ops =
  url: 'https://resellertest.enom.com/interface.asp'
  qs:
    pw: 'zola322'
    uid: 'sundaysenergy'
    command: 'GetAllDomains'

r ops, (err, resp, body) ->
  console.log body
