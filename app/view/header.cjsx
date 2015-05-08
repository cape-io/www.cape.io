React = require 'react'
Menu = require './menu'
{Link} = require 'react-router'

module.exports = React.createClass
  render: ->
    {title, about, tagline, settings, coverImg} = @props
    {primaryMenu, titleInNav, singlePage, aboutInHeader, taglineInHeader, bgImgs} = settings

    if about and aboutInHeader
      aboutEl = <p>{about}</p>
    else
      aboutEl = false
    if tagline and taglineInHeader
      taglineEl = <h2>{tagline}</h2>
    else
      taglineEl = false

    # Decide if the title should be in an h1 or within the navBar.
    if title and not titleInNav
      # Create title h1 and remove title variable.
      if singlePage
        TitleEl = <h1>{title}</h1>
      else
        TitleEl = <Link to="/"><h1>{title}</h1></Link>
      title = false

    if primaryMenu
      # Build primary menu.
      PrimaryMenuEl =
        <nav>
          <Menu menu={primaryMenu} title={title} />
        </nav>

    if bgImgs and coverImg
      headerStyle =
        backgroundImage: "url('#{coverImg}')"
    else
      headerStyle = {}
    <header style={headerStyle}>
      <div className="inner">
        {TitleEl}
        {taglineEl}
        {aboutEl}
        {PrimaryMenuEl}
      </div>
    </header>
