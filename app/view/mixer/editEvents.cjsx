urlParse = require('url').parse
React = require 'react'
{Input} = require 'react-bootstrap'
_ = require 'lodash'
FBevents = require '../fbEvents'

module.exports = React.createClass
  getInitialState: ->
    eventLink: ''
    eventId: null
    provider: 'facebook'
    status: null
    eventInfo: null

  fbEventInfo: (eventId) ->
    FB.api "/#{eventId}", (response) =>
      console.log response
      @setState eventInfo: response

  handleChange: (newSt) ->
    value = @refs.eventLink.getValue()
    {host, pathname} = urlParse(value, true, true)
    if host is 'www.facebook.com'
      parts = _.compact pathname.split('/')
      if parts[0] is 'events'
        # Get event information from facebook.
        if app and app.me and app.me.fbConnected
          @fbEventInfo(parts[1])
        @setState
          eventId: parts[1]
          eventLink: value
      else
        @setState {eventLink: value}
    else
      @setState
        eventLink: value

  render: ->
    {eventLink, eventId, eventInfo} = @state

    if eventInfo
      eventEl =  <div>
        <button>Submit</button>
        <FBevents events={[eventInfo]} />
      </div>
    else if eventId
      idEl = <div>{eventId}</div>

    <div className="event-add">
      <Input
        type="url"
        ref="eventLink"
        label="Event URL:"
        onChange={@handleChange}
        value={eventLink}
      />
      {idEl}
      {eventEl}
    </div>
