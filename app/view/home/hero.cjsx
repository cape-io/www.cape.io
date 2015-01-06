React = require 'react'

module.exports = React.createClass
  render: ->

    {title} = @props.data

    <section id="hero">
      <h1>{title}</h1>
    </section>
