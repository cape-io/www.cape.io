React = require 'react'
{RouteHandler} = require 'react-router'
_ = require 'lodash'

Menu = require './menu'

module.exports = React.createClass

  render: ->
    {pageData, sections, sectionsData} = @props

    SectionMenuEl = (sectionId, i) ->
      <Menu
        key={i}
        menu={sectionsData[sectionId]}
        className={sectionId}
        title={_.capitalize(sectionId)}
      />

    <main>
      <aside>
        <nav>
          { _.map sections, SectionMenuEl }
        </nav>
      </aside>
      <section>
        { React.createElement(RouteHandler, pageData) }
      </section>
    </main>
