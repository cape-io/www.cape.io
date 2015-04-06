React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'

MenuItem = React.createClass
  render: ->
    {link, title, section} = @props
    unless section
      section = 'page'

    if _.isString(link) and link.slice(0, 4) is 'http'
      # Make normal link
      linkEl = <a href={link}>{title}</a>
    else
      # Make router link.
      linkEl = <Link to={section} params={pageId: link}>{title}</Link>

    <li>
      {linkEl}
    </li>

module.exports = React.createClass
  render: ->
    {menu, className, title} = @props

    if title
      TitleEl = <h2>{title}</h2>

    <ul className={className or "menu"}>
      { TitleEl }
      {
        _.map menu, (item, i) ->
          {link, title, section, shortTitle} = item
          <MenuItem
            key={i}
            link={link}
            title={shortTitle or title}
            section={section}
          />
      }
    </ul>
