React = require 'react'

module.exports = React.createClass
  render: ->
    {data} = @props
    {title, tagline, since} = data
    yr = new Date().getFullYear()
    msg = "\u00a9 Copyright #{since}-#{yr}, #{title}"

    <footer>
      <p>{msg}</p>
    </footer>
