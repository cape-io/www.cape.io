React = require 'react'

Nav = require './nav'

module.exports = React.createClass
  render: ->

    {title} = @props.data

    <header className="container">
      <Nav data={@props.data} />
    </header>
