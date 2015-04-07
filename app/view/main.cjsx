React = require 'react'
{RouteHandler} = require 'react-router'
_ = require 'lodash'

Menu = require './menu'
Hero = require './hero'

module.exports = React.createClass

  render: ->
    {pageData, sections, sectionsData, lead, tagline, displayType, title} = @props

    SectionMenuEl = (sectionId, i) ->
      <Menu
        key={i}
        menu={sectionsData[sectionId]}
        className={sectionId}
        title={_.capitalize(sectionId)}
      />
    if displayType is 'hero'
      HeroEl = <Hero tagline={tagline} title={title} lead={lead} />
    <main>
      <aside>
        <nav>
          { _.map sections, SectionMenuEl }
        </nav>
      </aside>
      {HeroEl}
      <section>
        { React.createElement(RouteHandler, pageData) }
      </section>
    </main>
