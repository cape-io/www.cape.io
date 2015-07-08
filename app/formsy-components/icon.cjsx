'use strict'
React = require('react')
Icon = React.createClass(
  requiredProps:
    symbol: React.PropTypes.string.isRequired
    className: React.PropTypes.string
  defaultProps: className: ''
  render: ->
    className = 'glyphicon glyphicon-' + @props.symbol + ' ' + @props.className
    <span className={className} aria-hidden="true"></span>
)
module.exports = Icon
