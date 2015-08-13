React = require 'react'
{Link, Navigation} = require 'react-router'
_ = require 'lodash'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  mixins: [Navigation]

  handleSearch: (e) ->
    if e.preventDefault
      e.preventDefault()
    {value} = @refs.search.getDOMNode()
    q = @context.router.getCurrentQuery()
    unless q.search is value
      q.search = value.toLowerCase()
      @replaceWith 'opportunities', {}, q

  render: ->
    {sortBy, filterOut, search} = @context.router.getCurrentQuery()
    unless sortBy
      sortBy = 'latest'

    if filterOut is 'fee'
      query = {sortBy: sortBy, search: search}
      feeEl =
        <Link className="filter-fee-show" to="opportunities" query={query}>
          Include those with an entry fee.
        </Link>
    else
      query = {sortBy: sortBy, search: search, filterOut: 'fee'}
      feeEl =
        <Link className="filter-fee-hide" to="opportunities" query={query}>
          Hide those with an entry fee.
        </Link>

    if sortBy is 'latest'
      query =  {sortBy: 'deadline', search: search, filterOut: filterOut}
      sortEl =
        <Link className="deadline" to="opportunities" query={query}>
          Show nearing dealines first.
        </Link>
    else
      query =  {sortBy: 'latest', search: search, filterOut: filterOut}
      sortEl =
        <Link className="latest" to="opportunities" query={query}>
          Show recently posted first.
        </Link>

    <ul className="filter-list">
      <li className="form-group search">
        <form onSubmit={@handleSearch}>
          <label className="control-label col-sm-3" htmlFor="search">
            Search:
          </label>
          <input className="form-control" type="text" name="search"
            onChange={@handleSearch} onBlur={@handleSearch} ref="search"
            placeholder="keywords" value ={search or ''}
          />
        </form>
      </li>
      <li className="sort">
        {sortEl}
      </li>
      <li className="filters">
        {feeEl}
      </li>
    </ul>
