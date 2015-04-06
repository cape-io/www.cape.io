React = require 'react'
Menu = require './menu'
{Link} = require 'react-router'

module.exports = React.createClass
  render: ->
    {primaryMenu, title, titleInNav} = @props

    # Decide if the title should be in an h1 or within the navBar.
    if title and not titleInNav
      # Create title h1 and remove title variable.
      TitleEl = <Link to="/"><h1>{title}</h1></Link>
      title = false

    if primaryMenu
      # Build primary menu.
      PrimaryMenuEl =
        <nav>
          <Menu menu={primaryMenu} title={title} />
        </nav>

    <header>
      {TitleEl}
      {PrimaryMenuEl}
    </header>
