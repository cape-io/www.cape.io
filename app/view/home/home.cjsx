React = require 'react'

Hero = require './hero'

module.exports = React.createClass
  render: ->

    {data} = @props

    <main>
      <Hero data={data} />
    </main>
