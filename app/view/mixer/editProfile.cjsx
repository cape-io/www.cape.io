React = require 'react'
{RouteHandler} = require 'react-router'
{Input} = require 'react-bootstrap'

Menu = require '../menu'

module.exports = React.createClass
  getInitialState: ->
    editField: null

  handleChange: (newSt) ->
    @setState newSt

  editField: (fieldId) ->
    @setState editField: fieldId

  handleFieldSubmit: (fieldId, value) ->
    app.me.save fieldId, value

  render: ->
    {pic, title} = @props

    if title
      titleEl = <h2 className="display-name">{title}</h2>

    <div className="row profile-edit">
      {titleEl}
      <form className="form-horizontal">
        <fieldset>

        </fieldset>
      </form>
    </div>
