React = require 'react'
_ = require 'lodash'
{Link} = require 'react-router'

Wufoo = require './wufoo'
SlideShow = require './slideshow'
ImageGrid = require './imageGrid/imageGrid'
Quote = require './quote'
List = require './list'
FbEvents = require './fbEvents'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  render: ->
    {content, title, images, dir, wufoo, contents, displayType, quote, theme, filtered, data} = @props
    {_next, _previous, _sectionId, slug, path, filename} = @props
    if not theme then theme = {}
    if contents?.length or images?.length
      if displayType is 'slideShow' or displayType is 'slideshow'
        if not theme.slideShow then theme.slideShow = {slideDuration: 3500}
        displayProps = _.assign theme.slideShow, {
          images: images or contents
          baseDir: dir
        }
        SlideShowEl = React.createElement(SlideShow, displayProps)
      else if displayType is 'imageGrid'
        if not theme.imageGrid then theme.imageGrid = {height:400, width:400}
        displayProps = _.assign theme.imageGrid, {
          images: filtered or images or contents
          baseDir: dir
        }
        Grid = React.createElement(ImageGrid, displayProps)
      else if displayType is 'titleList'
        if not theme.titleList then theme.titleList = {dateFormat: 'L'}
        displayProps = _.assign theme.titleList, {
          items: images or contents
          sectionId: _sectionId
        }
        ListEl = React.createElement(List, displayProps)
      else
        console.log 'no display', displayType
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
    if _sectionId is 'fb-events' and data
      facebookEvents = <FbEvents events={data} />
    <div className="page">
      { if title and not theme.singlePage then <h1>{title}</h1> }
      { SlideShowEl }
      { if quote then React.createElement(Quote, quote) }
      { if _.isString content
          <div className="content" dangerouslySetInnerHTML={ __html: content }/>
      }
      { facebookEvents }
      { Pager }
      { Grid }
      { ListEl }
      { if wufoo then <Wufoo hash={wufoo.hash} subdomain={wufoo.subdomain} /> }
    </div>
