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
    {db, title, sha, domains, theme, currentYear, startYear} = @props
    {author, description, wufoo} = db
    {css, js, meta, settings} = theme
    {primaryMenu, homepageId} = settings
    {pageId, contentId} = @context.router.getCurrentParams()
    # Theme overrides the settings in index.yaml.
    pageId = pageId or homepageId or db.homepageId or 'homepage'
    console.log pageId

    # Grab pageData
    pageData = db[pageId] or {}
    pageTitle = if pageData.title then "#{title} | #{pageData.title}" else title

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
        <div className="container">
          <h2>Hi</h2>
          <Header primaryMenu={primaryMenu} />
          <Main pageData={pageData} />
          <Footer currentYear={currentYear} startYear={startYear} />
          <div id="fb-root"></div>
        </div>
      </body>
    </html>
