React = require 'react'

module.exports = React.createClass
  render: ->
    {author, source, txt, text, content} = @props
    if author or source
      byline = "—#{author or source}"
      if author and source
        byline += ", "

    <div className="quote">
      <p>{txt or text or content}</p>
      <p className="byline">
        {byline}
        {if author and source then <cite>{source}</cite>}
      </p>
    </div>
