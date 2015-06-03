React = require 'react'
{RouteHandler} = require 'react-router'
_ = require 'lodash'

Menu = require './menu'
Hero = require './hero'
AuthMenu = require './user/authMenu'
Contact = require './contact'

module.exports = React.createClass

  render: ->
    {pageData, filterIndex, lead, tagline, displayType, title, pages, theme, bgImg, contact, iframe} = @props
    {hasLogin, singlePage, bgImgs} = pageData.theme

    SectionMenuEl = (sectionId, i) ->
      <Menu
        key={i}
        menu={sectionsData[sectionId]}
        className={sectionId}
        title={_.capitalize(sectionId)}
      />

    if displayType is 'hero'
      HeroEl = <Hero tagline={tagline} title={title} lead={lead} />

    if filterIndex and filterIndex._blocks
      filterMenuBlocks = _.map filterIndex._blocks, (block) ->
        <Menu key={block.key} menu={block.menu} className={block.key} title={block.title} />
    if pages
      pagesMenuBlock = <Menu menu={pages} title="Pages" />
    if hasLogin
      userMenu = <AuthMenu />
    if (filterMenuBlocks or pagesMenuBlock) and not iframe
      sidebar =
        <aside>
          <nav> { pagesMenuBlock } { filterMenuBlocks } { userMenu } </nav>
        </aside>

    if singlePage
      # Include contact form.
      contactEl = <Contact contact={pageData.contact} title={title} />

    if bgImgs and bgImg
      mainStyle =
        backgroundImage: "url('#{bgImg.urlDark}')"
    else
      mainStyle = {}

    <main style={mainStyle}>
      {sidebar}
      {HeroEl}
      <section>
        { React.createElement(RouteHandler, pageData) }
      </section>
      {contactEl}
    </main>
