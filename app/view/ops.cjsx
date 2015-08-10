React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'

OpPreview = require './opPreview'
inBrowser = typeof window isnt "undefined"

module.exports = React.createClass

  getInitialState: ->
    isMounted: false

  handleFetch: (collection) ->
    @setState
      isMounted: true

  componentDidMount: ->
    @fetchOps()

  fetchOps: ->
    if app.ops.length > 1
      return false
    app.ops.fetch {success: @handleFetch}

  render: ->
    {isMounted} = @state
    if (inBrowser and app.ops.length > 1) or isMounted
      items = app.ops.map (model) ->
        <OpPreview key={model.id} model={model} />
    else
      items = <li>loading.</li>

    <ul className="title-list">
      {items}
    </ul>
