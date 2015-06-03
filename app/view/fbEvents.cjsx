React = require 'react'

module.exports = React.createClass
  render: ->
    {events} = @props

    <ul className="fb-events">
      {
        events.map (eventInfo) ->
          {name, cover, description, start_time, location} = eventInfo
          <li className="item event">
            <ul className="info">
              <li className="name">{name}</li>
              <li className="cover"><img src={cover.source} alt={cover.id} /></li>
              <li className="start">{start_time}</li>
              <li className="end">{end_time}</li>
              <li className="location">{location}</li>
              <li className="description">{description}</li>
            </ul>
          </li>
      }
    </ul>
