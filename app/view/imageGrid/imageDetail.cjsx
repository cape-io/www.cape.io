React = require 'react'
{Link} = require 'react-router'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }

  render: ->
    {id, filename, maxIndex, i, skip} = @props
    imgUrl = "//ezle.imgix.net/#{id}?w=1200"
    nextIndex = if i is maxIndex then 0 else i+1
    prevIndex = if i is 0 then maxIndex else i-1
    path = @context.router.getCurrentPathname()
    if skip
      msg = "Missing image. Please continue to the next slide. (#{filename})"
      ImgEl =
        <span className="missing-image">
          {msg}
        </span>
    else
      ImgEl =
        <Link to={path} role="button" onClick={@close}>
          <img className="large" src={imgUrl} alt={filename} />
        </Link>

    <div className="img-detail">
      <Link className="button close" to={path} role="button"> Close </Link>
      <Link className="button left previous" to={path} query={i:prevIndex} role="button"> Previous </Link>
      {ImgEl}
      <Link className="button right next" to={path} query={i:nextIndex} role="button"> Next </Link>
    </div>
