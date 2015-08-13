React = require 'react'
{Link} = require 'react-router'

inBrowser = typeof window isnt "undefined"

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }

  getInitialState: ->
    model: null

  handleFetch: (err, model) ->
    if model
      if model.body
        @setState
          model: model
      else
        model.fetch success: (m) => @setState(model:m)

  componentDidMount: ->
    {id} = @context.router.getCurrentParams()
    app.ops.collection.getOrFetch parseInt(id), @handleFetch

  render: ->
    {id} = @context.router.getCurrentParams()
    {model} = @state
    if model or (inBrowser and model = app.ops.get(id))
      {deadlineStr, title, body, preview} = model
      if not body then body = preview
    else
      title = 'loading '+id

    <div className="opportunity">
      <h2>{title}</h2>
      {
        if deadlineStr
          <div className="deadline"><span className="label">Application Deadline: </span>{deadlineStr}</div>
      }
      {
        if body
          <div className="body" dangerouslySetInnerHTML={ __html: body } />
      }
      <Link to="opportunities">Back to list</Link>
    </div>
