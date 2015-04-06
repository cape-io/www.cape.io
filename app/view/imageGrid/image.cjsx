React = require 'react'
{Link} = require 'react-router'
Qs = require 'qs'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  render: ->
    {id, filename, i, width, height, domain, fit, crop} = @props
    domain = domain or 'ezle.imgix.net'
    if !width and !height
      width = 500
    url = "//#{domain}/#{id}"
    if width or height or fit
      url += "?" + Qs.stringify({ h: height, w: width, fit: fit, crop: crop })

    path = @context.router.getCurrentPathname()
    <Link to={path} query={i:i} role="button" activeClassName="" className="">
      <img className="small" src={url} alt={filename} />
    </Link>
