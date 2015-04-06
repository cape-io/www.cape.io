React = require 'react'
_ = require 'lodash'
{Link} = require 'react-router'

Wufoo = require './wufoo'
SlideShow = require './slideshow'
ImageGrid = require './imageGrid/imageGrid'
Quote = require './quote'
List = require './list'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  render: ->
    {content, title, images, dir, wufoo, contents, display, quote, theme} = @props
    {_next, _previous, _sectionId, slug, path, filename} = @props
    if not theme then theme = {}
    if contents?.length or images?.length
      if display is 'slideShow' or display is 'slideshow'
        if not theme.slideShow then theme.slideShow = {slideDuration: 3500}
        displayProps = _.merge theme.slideShow, {
          images: images or contents
          baseDir: dir
        }
        SlideShowEl = React.createElement(SlideShow, displayProps)
      else if display is 'imageGrid'
        if not theme.imageGrid then theme.imageGrid = {height:400, width:400}
        displayProps = _.merge theme.imageGrid, {
          images: images or contents
          baseDir: dir
        }
        Grid = React.createElement(ImageGrid, displayProps)
      else if display is 'titleList'
        if not theme.titleList then theme.titleList = {dateFormat: 'L'}
        displayProps = _.merge theme.titleList, {
          items: images or contents
          sectionId: _sectionId
        }
        ListEl = React.createElement(List, displayProps)
      else
        console.log 'no display'
    if _next and _previous
      currentPath = '/' + _sectionId
      prevUrl = currentPath + '/' + (_previous.slug or _previous.path or _previous.filename)
      nextUrl = currentPath + '/' + (_next.slug or _next.path or _next.filename)
      Pager =
        <aside className="pager">
          <Link className="button left previous" to={prevUrl} title={_previous.title}>
            Previous
          </Link>
          <Link className="button right next" to={nextUrl} title={_next.title}>
            Next
          </Link>
        </aside>

    <div className="page">
      { if title then <h1>{title}</h1> }
      { SlideShowEl }
      { if quote then React.createElement(Quote, quote) }
      { if content
          <div className="content" dangerouslySetInnerHTML={ __html: content }/>
      }
      { Pager }
      { Grid }
      { ListEl }
      { if wufoo then <Wufoo hash={wufoo.hash} subdomain={wufoo.subdomain} /> }
    </div>
