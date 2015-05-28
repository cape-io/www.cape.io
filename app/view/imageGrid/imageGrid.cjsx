React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'

ImageText = require './imageText'
ImageDetail = require './imageDetail'
Image = require './image'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  getInitialState: ->
    isMounted: false
    imgDimensions: []

  componentDidMount: ->
    {calculateWidth, calculateHeight, images} = @props

    if calculateWidth or calculateHeight
      console.log 'calc'
      imageEls = document.querySelectorAll('.image-grid .image img')
      imgDimensions = _.map imageEls, (imgEl) ->
        if imgEl.naturalWidth is 0
          console.log 'Image not loaded yet.'
        width: imgEl.clientWidth or 300
        height: imgEl.clientHeight or 300

    @setState
      isMounted: true
      imgDimensions: imgDimensions or []

  render: ->
    {images, width, height, fit, domain, calculateWidth, calculateHeight, setContainerWidth, baseDir} = @props
    {isMounted, imgDimensions} = @state
    {i} = @context.router.getCurrentQuery()
    i = parseInt(i)
    maxIndex = images.length - 1

    ImageEl = (image, index) =>
      if _.isString image
        key = index
        id = if baseDir then baseDir + '/' + image
      else
        {id, filename, rev, images, title, content, year, medium, sold, key} = image
        if images
          {id, filename, rev} = images[0]
      key = key or rev or id or i

      # Try to figure out if this element has an image.
      if id
        ext = id.split('.').pop()
        unless _.contains ['jpg', 'jpeg', 'gif', 'png'], ext
          noImage = true
      if isMounted and i is index
        Detail = <ImageDetail id={id} filename={filename} i={i} maxIndex={maxIndex} skip={noImage}/>
      if title or content or year or medium
        Text = React.createElement(ImageText, image)
      className = if sold then "image sold" else "image"
      style = {}
      if isMounted
        if calculateWidth then style.width = imgDimensions[index].width
        if calculateHeight then style.height = imgDimensions[index].height
        dimensions = imgDimensions[index]
      unless noImage
        ImageElement =
          <Image
            id={id}
            filename={filename}
            i={index}
            height={height}
            width={width}
            domain={domain}
            dimensions={dimensions}
            fit={fit}
          />
      unless ImageElement or Text or Detail
        return false
      <li className={className} key={key} style={style} >
        <figure>
          {ImageElement}
          {Text}
        </figure>
        {Detail}
      </li>

    if setContainerWidth
      paddingMargin = images.length * 40
      if isMounted
        widthOfImages = _.sum(imgDimensions, 'width')
      else
        widthOfImages = (images.length + 4) * (width or height)
      style = {width: widthOfImages + paddingMargin}
    console.log 'images', images.length
    <ul className="image-grid" style={style}>
      { _.map images, ImageEl }
    </ul>
