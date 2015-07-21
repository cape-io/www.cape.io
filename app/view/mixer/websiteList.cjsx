React = require 'react'
{Link} = require 'react-router'
{Table, unsafe} = require 'reactable'
{pick, find, contains, filter} = require 'lodash'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }

  render: ->
    {user} = @props

    sites = user.websites.map (site) ->
      info = pick site, 'id', 'facebook', 'plan', 'vhost', 'sld', 'tld', 'title'
      info.id = <Link to="site" params={siteId: info.id}>{info.id}</Link>
      if site.ssFiles?.length
        dropbox = find site.ssFiles, (f) ->
          contains(['dbox', 'dropbox'], f.provider)
        if dropbox
          info.dropbox = dropbox.provider+':'+dropbox.prefix
      info.theme = site.theme?.id
      return info

    <div className="sites">
      <h3>Websites</h3>
      <div className="skinny scrollable">
        <Table data={sites} sortable={true} />
      </div>
    </div>
