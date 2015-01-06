React = require 'react'

Event = require './event'

module.exports = React.createClass
  render: ->
    {events} = @props.data

    Events = for item, i in events
      {id} = item
      <Event key={id} item={item} />

    <section id="events">
      <h3>Upcoming</h3>
      <ul className="events">
        {Events}
      </ul>
    </section>
