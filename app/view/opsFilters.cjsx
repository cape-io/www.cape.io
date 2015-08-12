React = require 'react'
{Link} = require 'react-router'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }

  render: ->
    {sortBy, filterOut} = @context.router.getCurrentQuery()

    unless sortBy
      sortBy = 'latest'

    if filterOut is 'fee'
      feeEl =
        <Link className="filter-fee-show" to="opportunities" query={sortBy: sortBy}>
          Include those with an entry fee.
        </Link>
    else
      feeEl =
        <Link className="filter-fee-hide" to="opportunities" query={filterOut: 'fee', sortBy: sortBy}>
          Hide those with an entry fee.
        </Link>

    if sortBy is 'latest'
      sortEl =
        <Link className="deadline" to="opportunities" query={sortBy: 'deadline', filterOut: filterOut}>
          Show nearing dealines first.
        </Link>
    else
      sortEl =
        <Link className="latest" to="opportunities"
          query={sortBy: 'latest', filterOut: filterOut}
        >
          Show recently posted first.
        </Link>

    <ul className="filter-list">
      <li className="sort">
        {sortEl}
      </li>
      <li className="filters">
        {feeEl}
      </li>
    </ul>
