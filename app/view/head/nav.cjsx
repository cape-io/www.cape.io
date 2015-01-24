React = require 'react'

{Nav, Navbar} = require 'react-bootstrap'
{NavItemLink} = require 'react-router-bootstrap'
{Link} = require 'react-router'

module.exports = React.createClass
  render: ->
    {title} = @props.data
    Brand = <Link to="app">{title}</Link>
    <Navbar brand={Brand}>
      <Nav>
        <NavItemLink to="start">Get Started</NavItemLink>
        <NavItemLink to="domains">Domain Renewal</NavItemLink>
        <NavItemLink to="claim">Claim Your Site</NavItemLink>
      </Nav>
    </Navbar>
