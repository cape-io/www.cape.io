React = require 'react'
_ = require 'lodash'

Slide = React.createClass
  render: ->
    {caption, url, active, baseDir, width} = @props
    className = if active then 'slide active' else 'slide'
    if caption
      CaptionEl = <p className="slide-caption">{caption}</p>
    unless width
      width = 500
    unless url.slice(0, 4) is 'http'
      unless url[0] is '/'
        url = '/'+url
      url = "http://ezle.imgix.net/#{baseDir}#{url}?w=#{width}"
    <li className={className}>
      <img src={url} />
      {CaptionEl}
    </li>

module.exports = React.createClass
  getInitialState: ->
    currentIndex: 0

  tick: ->
    {images} = @props
    {currentIndex} = @state
    maxIndex = images.length-1
    nextIndex = currentIndex + 1
    nextIndex = if nextIndex is maxIndex then 0 else nextIndex
    @setState currentIndex: nextIndex

  componentDidMount: ->
    {slideDuration} = @props
    slideDuration = slideDuration or 4000
    @interval = setInterval @tick, slideDuration

  componentWillUnmount: ->
    clearInterval @interval

  render: ->
    {currentIndex} = @state
    {images, baseDir} = @props
    console.log 'slideShow'
    SlideEl = (props, i) ->
      if _.isString props
        key = i
        url = props
      else
        {id, key, alt, filename, caption, url, rev} = props
        key = key or rev or id or i
      active = currentIndex is i
      if caption?.text
        caption = caption.text
      <Slide
        url={url}
        key={key}
        caption={caption}
        active={active}
        baseDir={baseDir}
      />

    <ul className="slideshow">
      { _.map images, SlideEl }
    </ul>
