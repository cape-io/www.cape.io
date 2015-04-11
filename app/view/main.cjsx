React = require 'react'
{RouteHandler} = require 'react-router'
_ = require 'lodash'

Menu = require './menu'
Hero = require './hero'

module.exports = React.createClass

  render: ->
    {pageData, filterIndex, lead, tagline, displayType, title, pages} = @props

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

    <main>
      <aside>
        <nav>
          { if pages then <Menu menu={pages} title="Pages" /> }
          { filterMenuBlocks }
        </nav>
      </aside>
      {HeroEl}
      <section>
        { React.createElement(RouteHandler, pageData) }
      </section>
    </main>
