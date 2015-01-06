React = require 'react'

module.exports = React.createClass
  render: ->
    {instagram} = @props.data

    pics = for pic, i in instagram
      <li className="four columns" key={pic.id}>
        <div className="polaroid">
          <img src={pic.url} width={pic.width} height={pic.height} />
          <p>{pic.caption}</p>
        </div>
      </li>

    <section id="instagram">
      <h3>From Instagram</h3>
      <ul className="group"> {pics} </ul>
    </section>
