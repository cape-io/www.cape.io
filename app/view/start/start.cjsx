React = require 'react'

module.exports = React.createClass
  render: ->

    {domains} = @props.data

    <main className="container">
      <div className="group">
        <div className="six columns offset-by-three">
          <h2>Getting Started</h2>
          <p>Enter your Facebook page id.</p>
        </div>
      </div>
    </main>
