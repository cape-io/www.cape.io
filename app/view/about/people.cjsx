React = require 'react'

Member = require './person'

module.exports = React.createClass
  render: ->

    {people, title, id} = @props

    Members = for person, i in people
      {filename} = person

      <Member key={filename} person={person} />

    <article id={id} className="toggle border-top">
      <h2>{title}</h2>
      <ul className="row add-top">
        {Members}
      </ul>
    </article>
