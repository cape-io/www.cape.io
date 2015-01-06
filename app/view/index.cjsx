React = require 'react'

{RouteHandler} = require 'react-router'

Head = require './head/head'
Foot = require './foot/foot'

module.exports = React.createClass
  render: ->
    {data} = @props
    {title} = @props.data

    <html>
      <head>
        <title>{title}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" />
        <link rel="stylesheet" href="/assets/app.css" />
      </head>
      <body>
        <div id="wrapper">
          <Head data={data} />
          <RouteHandler data={data} />
          <Foot data={data} />
        </div>
        <script src="/assets/app.js" />
      </body>
    </html>
