React = require 'react'
_ = require 'lodash'

module.exports = React.createClass
  eventEl: (eventInfo) ->
    {name, cover, description, start_time, end_time, location, id} = eventInfo
    eventUrl = "https://www.facebook.com/events/#{id}/"
    <li className="item event">
      <ul className="info">
        {if name then <li className="name"><h3><a href={eventUrl}>{name}</a></h3></li>}
        {if cover then <li className="cover"><img src={cover.source} alt={cover.id} /></li>}
        {if start_time then <li className="start">{start_time}</li>}
        {if end_time then <li className="end">{end_time}</li>}
        {if location then <li className="location">{location}</li>}
        {if description then <li className="description" dangerouslySetInnerHTML={ __html: description }></li>}
      </ul>
    </li>

  render: ->
    {events} = @props

    <ul className="fb-events">
      { _.map events, @eventEl }
    </ul>
