React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  getInitialState: ->
    isMounted: false

  handleFetch: (collection) ->
    @setState
      isMounted: true

  componentDidMount: ->
    app.ops.fetch {success: @handleFetch}

  render: ->
    {isMounted} = @state

    if isMounted
      items = app.ops.map (model) ->
        {title, id, deadlineStr, preview} = model

        <li key={id}>
          <h2><Link to="opDetail" params={id: id}>{title}</Link></h2>
          <div className="deadline"><span className="label">Application Deadline: </span>{deadlineStr}</div>
          <div className="preview" dangerouslySetInnerHTML={ __html: preview } />
        </li>
    else
      items = <li>loading.</li>

    <ul className="title-list">
      {items}
    </ul>
