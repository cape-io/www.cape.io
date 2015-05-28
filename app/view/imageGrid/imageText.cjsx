React = require 'react'

module.exports = React.createClass
  render: ->
    {title, collection, content, year, size, medium, height, width, sold, date} = @props
    if height or width and not size
      size = "#{height}\" × #{width}\""

    <figcaption className="info">
      {if title then <h2>{title}</h2>}
      <ul className="details">
        {if collection then <li className="collection">{collection}</li>}
        {if year then <li className="year">{year}</li>}
        {if date then <li className="date">{date}</li>}
        {if size then <li className="size">{size}</li>}
        {if medium then <li className="medium">{medium}</li>}
      </ul>
      { if content
          <div className="content" dangerouslySetInnerHTML={ __html: content }/>
      }
    </figcaption>
