React = require 'react'

{RouteHandler} = require 'react-router'

Head = require './head/head'
Foot = require './foot/foot'

module.exports = React.createClass
  render: ->
    {data} = @props
    {title, sha} = data
    appFileName = sha or 'app'
    cssFilePath = "/assets/#{appFileName}.css"
    jsFilePath = "/assets/#{appFileName}.js"

    <html>
      <head>
        <title>{title}</title>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href={cssFilePath} />
      </head>
      <body>
        <Head data={data} />
        <RouteHandler data={data} />
        <Foot data={data} />
        <script src="https://checkout.stripe.com/checkout.js" type="text/javascript" />
        <script src={jsFilePath} type="text/javascript" />
        <div id="fb-root"></div>
        <script id="facebook-jssdk" src="//connect.facebook.net/en_US/sdk.js" type="text/javascript" />
      </body>
    </html>
