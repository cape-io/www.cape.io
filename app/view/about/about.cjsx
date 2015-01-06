React = require 'react'

AboutPeople = require './people'

module.exports = React.createClass
  render: ->

    {data} = @props
    {board, staff} = data.content
    council = data.content['curatorial-advisory-council']

    <main>
      <AboutPeople people={staff} id="staff" title="Staff." />
      <AboutPeople people={council} id="council" title="Curatorial Advisory Council." />
      <AboutPeople people={board} id="board" title="Board." />
    </main>
