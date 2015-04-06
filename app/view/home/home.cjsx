React = require 'react'

Hero = require './hero'

module.exports = React.createClass
  getInitialState: ->
    name: null
    facebook: false

  render: ->
    {title, tagline, lead, body} = @props

    <main>
      <Hero title={title} tagline={tagline} lead={lead} />
      <article className="container">
        <div className="content" dangerouslySetInnerHTML={__html: body} />
      </article>
    </main>
