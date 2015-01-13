React = require 'react'
cx = require '../cx'

module.exports = React.createClass

  render: ->
    {builtDesigned} = @props

    if builtDesigned and length = builtDesigned.length
      last_i = length-1
      className = "credits count-#{length}"
      Links = builtDesigned.map (item, i) =>
        {name, link} = item
        first = i is 0
        last = i is last_i

        if last
          seperator = ' and '
        else if not first
          seperator = ', '

        <span key={name} className={cx(credit: true, first: first, last: last)}>
          {seperator}<a href={link} title={name} target="_blank">{name}</a>
        </span>
    else
      Links = <span>a tallented group of folks</span>

    <p className={className}>
      Built and designed by {Links}.
    </p>
