React = require 'react'

module.exports = React.createClass
  # getInitialState: ->

  render: ->
    {handleToggle, menuOpen} = @props
    if menuOpen
      className = "toggle close"
      innerText = "Hide Menu"
    else
      className = "toggle open"
      innerText = "Show Menu"
    <button onClick={handleToggle} className={className} type="button">
      {innerText}
    </button>
