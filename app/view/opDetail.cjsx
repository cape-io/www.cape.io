React = require 'react'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }

  getInitialState: ->
    model: null

  handleFetch: (err, model) ->
    @setState
      model: model

  componentDidMount: ->
    {id} = @context.router.getCurrentParams()
    app.ops.getOrFetch parseInt(id), @handleFetch

  render: ->
    {id} = @context.router.getCurrentParams()
    {model} = @state
    if model
      {deadlineStr, title, body} = model
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
    </div>
