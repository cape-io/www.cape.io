React = require 'react'
{Link} = require 'react-router'

module.exports = React.createClass


  getBody: ->
    {model} = @props
    unless model.body
      model.fetch()

  render: ->
    {model} = @props
    {title, id, deadlineStr, preview, createdStr} = model

    <li key={id} onMouseDown={@getBody}>
      <h2><Link to="opDetail" params={id: id}>{title}</Link></h2>
      <div className="deadline"><span className="label">Application Deadline: </span>{deadlineStr}</div>
      <div className="created"><span className="label">Posted: </span>{createdStr}</div>
      <div className="preview" dangerouslySetInnerHTML={ __html: preview } />
    </li>
