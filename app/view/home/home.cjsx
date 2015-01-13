React = require 'react'

Hero = require './hero'

content = require '../../data/about'

module.exports = React.createClass
  getInitialState: ->
    name: null
    facebook: false

  render: ->
    {lead, body} = content
    {data} = @props

    <main>
      <Hero data={data} lead={lead} />
      <div className="content" dangerouslySetInnerHTML={__html: body} />
    </main>
