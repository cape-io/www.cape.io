React = require 'react'
{Link} = require 'react-router'

module.exports = React.createClass


  getBody: ->
    {model} = @props
    unless model.body
      model.fetch()

  render: ->
    {model} = @props
    {title, id, deadlineStr, preview, createdStr, fee} = model
    className = if fee then 'has-fee' else 'free'
    <li key={id} onMouseDown={@getBody} className={className}>
      <h2><Link to="opDetail" params={id: id}>{title}</Link></h2>
      <div className="deadline"><span className="label">Application Deadline: </span>{deadlineStr}</div>
      <div className="created"><span className="label">Posted: </span>{createdStr}</div>
      <div className="preview" dangerouslySetInnerHTML={ __html: preview } />
    </li>
