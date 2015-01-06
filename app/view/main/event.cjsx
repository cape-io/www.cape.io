React = require 'react'

module.exports = React.createClass
  render: ->
    {name, start_time, end_time, location} = @props.item
    dateStr = "#{start_time} - #{end_time}"

    <li className="event">
      <h2>{name}</h2>
      <div className="date">{dateStr}</div>
    </li>
