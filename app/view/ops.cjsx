React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'

OpPreview = require './opPreview'
OpsFilters = require './opsFilters'

inBrowser = typeof window isnt "undefined"

handleFilters = (query) ->
  {sortBy, filterOut} = query
  unless inBrowser
    return
  config = {}
  if sortBy is 'deadline'
    config.comparator = 'deadline'
  if filterOut is 'fee'
    config.where = {fee: false}
  app.ops.configure(config, true)


module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }

  statics:
    willTransitionTo: (transition, params, query) ->
      handleFilters(query)

  getInitialState: ->
    isMounted: false

  componentDidMount: ->
    @fetchOps()

  # componentWillReceiveProps: (nextProps) ->

  handleFetch: (collection) ->
    @setState
      isMounted: true

  fetchOps: ->
    if app.ops.length > 1
      return false
    app.ops.collection.fetch {success: @handleFetch}

  render: ->
    {isMounted} = @state
    if (inBrowser and app.ops.length > 1) or isMounted
      items = app.ops.map (model) ->
        <OpPreview key={model.id} model={model} />
    else
      items = <li>loading.</li>

    <div id="opportunities-list">
      <OpsFilters />
      <ul className="title-list">
        {items}
      </ul>
    </div>
