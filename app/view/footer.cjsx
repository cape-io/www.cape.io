React = require 'react'

module.exports = React.createClass
  render: ->
    {startYear, currentYear, title, author} = @props
    if startYear
      startYear += '–'
    else
      startYear = ''

    txt = "All works © #{startYear}#{currentYear} #{author or title}"
    <footer>
      <p>{txt}</p>
      <small className="credits">Built by <a href="http://www.ookb.co/">OOKB</a>, Powered by <a href="http://www.ezle.io/">EZLE</a> / <a href="http://www.cape.io/">CAPE</a></small>
    </footer>
