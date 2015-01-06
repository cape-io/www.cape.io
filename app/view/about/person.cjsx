React = require 'react'
{OverlayTrigger, Button, Popover} = require 'react-bootstrap'

module.exports = React.createClass
  render: ->

    {firstname, lastname, position, content, filename, email, name} = @props.person
    fullName = name or "#{firstname} #{lastname}"
    imgSrc = "/img/headshot/#{filename}.jpg"

    if position
      Position = <h3>{position}</h3>

    if email
      Email = <div className="text-center email">{email}</div>

    if content
      Content = <div className="bio-content" dangerouslySetInnerHTML={{__html:content}} />

    <li className="col-xs-4 col-sm-3 col-md-2 bio">
      <OverlayTrigger trigger="click" placement="bottom" overlay={<Popover>{Content}</Popover>}>
        <Button bsStyle="default">
          <img src={imgSrc} className="img-circle" />
          <h2>{fullName}</h2>
        </Button>
      </OverlayTrigger>
      {Position}
      {Email}
    </li>
