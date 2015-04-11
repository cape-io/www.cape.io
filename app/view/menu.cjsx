React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'

MenuItem = React.createClass
  render: ->
    {link, title, shortTitle, to, qty, params} = @props
    to = to or 'page'
    params = params or {}

    if link
      params['pageId'] = link

    if qty
      qtyEl = <span className="filter-qty">{qty}</span>

    if link and _.isString(link) and link.slice(0, 4) is 'http'
      # Make normal link
      linkEl = <a href={link}>{title}</a>
    else
      # Make router link.
      linkEl = <Link to={to} params={params}>{title or shortTitle}{qtyEl}</Link>

    <li>{linkEl}</li>

module.exports = React.createClass
  render: ->
    {menu, className, title} = @props

    if title
      TitleEl = <h2>{title}</h2>

    <ul className={className or "menu"}>
      { TitleEl }
      {
        _.map menu, (item, i) ->
          item['key'] = i
          React.createElement(MenuItem, item)
      }
    </ul>
