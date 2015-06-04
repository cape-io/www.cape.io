React = require 'react'
{RouteHandler} = require 'react-router'
_ = require 'lodash'

Header = require './header'
Main = require './main'
Footer = require './footer'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  render: ->
    {db, sha, domains, theme, currentYear, startYear, me, pages, filterIndex, facebook} = @props
    {author, description, wufoo, tagline, lead, title, about, mission} = db
    {css, js, meta, settings, navTitle} = theme
    {homepageId, display, defaultDisplay, fluid} = settings
    {pageId, contentId, filterType, filterValue} = @context.router.getCurrentParams()
    if currentRoutes = @context.router.getCurrentRoutes()
      currentRouteIndex = currentRoutes.length-1
      currentRoute = currentRoutes[currentRouteIndex]
      parentRoute = currentRoutes[currentRouteIndex-1]
    # Theme overrides the settings in index.yaml.
    pageId = pageId or currentRoute?.name or homepageId or db.homepageId or 'homepage'
    displayType = display?[pageId] or defaultDisplay or 'imageGrid'

    # Grab pageData
    if pageId is 'mixer' or parentRoute?.name is 'mixer'
      pageData = {user: me}
    else if contentId
      pageData = db[pageId]?[contentId] or {}
    else if filterType
      #console.log filterType, filterValue, db[pageId]
      pageData = db[pageId]
      pageData.filtered = _.map filterIndex[pageId].option[filterType][filterValue], (contentIndex) ->
        pageData.contents[contentIndex]
      console.log filterIndex[pageId].option[filterType][filterValue], pageData.filtered.length
    else if pageId is 'fb-events'
      pageData = facebook.events
    else
      pageData = db[pageId] or @props[pageId] or db
    unless filterType
      delete pageData.filtered
    pageData._sectionId = pageId
    #console.log pageId, displayType, pageData._sectionId

    pageData.displayType = displayType
    pageData.theme = settings
    pageTitle = if pageData.title then "#{title} | #{pageData.title}" else title

    if currentRoute?.name is 'iframe'
      bodyEl =
        <Main
          pageData={pageData}
          tagline={tagline}
          lead={lead}
          title={title}
          pages={pages}
          filterIndex={filterIndex}
          bgImg={facebook?.coverPhotos?[1]}
          iframe={true}
        />
    else
      bodyEl =
        <div className="iframe">
          <Header
            title={title}
            tagline={tagline}
            about={about}
            mission={mission}
            settings={settings}
            coverImg={facebook?.coverPhotos?[0]}
          />
          <Main
            pageData={pageData}
            tagline={tagline}
            lead={lead}
            title={title}
            pages={pages}
            filterIndex={filterIndex}
            bgImg={facebook?.coverPhotos?[1]}
          />
          <Footer currentYear={currentYear} startYear={startYear} author={author} title={title} />
          <div id="fb-root"></div>
        </div>

    <html>
      <head>
        <title>{pageTitle}</title>
        <meta charSet="utf-8" />
        {
          _.map meta, (metaArr, i) ->
            <meta key={'m'+i} name={metaArr[0]} content={metaArr[1]} />
        }
        {
          _.map css, (cssFilePath, i) ->
            <link key={'c'+i} rel="stylesheet" type="text/css" href={cssFilePath} />
        }
        {
          _.map js, (jsFilePath, i) ->
            <script key={'j'+i} type="text/javascript" src={jsFilePath} async defer />
        }
      </head>
      <body>
        {bodyEl}
      </body>
    </html>
