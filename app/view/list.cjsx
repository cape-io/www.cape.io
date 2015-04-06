React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'
moment = require 'moment'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  getInitialState: ->
    isMounted: false

  componentDidMount: ->
    @setState
      isMounted: true

  render: ->
    {items, sectionId, dateFormat} = @props
    {isMounted} = @state
    {i} = @context.router.getCurrentQuery()
    i = parseInt(i)
    maxIndex = items.length - 1

    ItemEl = (item, index) =>
      {id, filename, rev, title, date, slug, path} = item
      unless title
        return false
      key = key or rev or id or i
      currentPath = '/' + sectionId
      url = currentPath + '/' + (slug or path or filename)
      if date
        dateStr = moment(date).format(dateFormat) + " » "
        DateEl = <span className="date">{dateStr}</span>
      Title =
        <Link to={url} role="button">
          {title}
        </Link>
      <li key={key}>
        { DateEl }
        { Title }
      </li>

    <ul className="title-list">
      { _.map items, ItemEl }
    </ul>
