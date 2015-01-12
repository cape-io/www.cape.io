React = require 'react'

Hero = require './hero'

module.exports = React.createClass
  getInitialState: ->
    name: null
    facebook: false

  render: ->

    {data} = @props

    <main>
      <Hero data={data} />
    </main>
