React = require 'react'

module.exports = React.createClass
  render: ->
    {events} = @props

    <ul className="fb-events">
      {
        events.map (eventInfo) ->
          {name, cover, description, start_time, end_time, location} = eventInfo
          <li className="item event">
            <ul className="info">
              {if name then <li className="name">{name}</li>}
              {if cover then <li className="cover"><img src={cover.source} alt={cover.id} /></li>}
              {if start_time then <li className="start">{start_time}</li>}
              {if end_time then <li className="end">{end_time}</li>}
              {if location then <li className="location">{location}</li>}
              {if description then <li className="description" dangerouslySetInnerHTML={ __html: description }></li>}
            </ul>
          </li>
      }
    </ul>
