React = require 'react'

Nav = require './nav'

module.exports = React.createClass
  render: ->

    {title} = @props.data

    <header className="navbar" role="banner">
      <div id="upperdeck">
        <h1>{title}</h1>
        <section className="description col-sm-4">
        </section>
      </div>
      <div id="lowerdeck">
        <Nav data={@props.data} />
      </div>
    </header>
