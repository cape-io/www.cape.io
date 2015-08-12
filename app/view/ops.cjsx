React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'

OpPreview = require './opPreview'
inBrowser = typeof window isnt "undefined"

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }

  handleFilters: ->
    query = @context.router.getCurrentQuery()
    config = {}
    if query?.sortBy is 'deadline'
      config.comparator = 'deadline'
    if config.comparator
      app.ops.configure(config)

  getInitialState: ->
    isMounted: false

  handleFetch: (collection) ->
    @setState
      isMounted: true

  componentDidMount: ->
    @handleFilters()
    @fetchOps()

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
    <div>
      <ul className="filter-list">
        <li><Link to="opportunities" query={sortBy: 'deadline'}>Ending soon.</Link></li>
      </ul>
      <ul className="title-list">
        {items}
      </ul>
    </div>
