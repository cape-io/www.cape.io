React = require 'react'
{Link} = require 'react-router'
{Table, unsafe} = require 'reactable'
{pick, find, contains, filter} = require 'lodash'
t = require 'tcomb-form'
Form = t.form.Form
FileSource = t.struct(
  provider: t.enums({dbox: 'Dropbox Shared File', dropbox: 'Dropbox Supersimple', react: 'Website Generator'})
  prefix: t.Str
)
Website = t.struct {
  id: t.maybe(t.Str)
  title: t.Str
  sld: t.Str
  vhost: t.maybe(t.Str)
  ssFiles: t.list(FileSource)
  facebook: t.maybe(t.Str)
  plan: t.enums({free: 'Free', light: 'Light', basic: 'Basic', advanced: 'Advanced', pro: 'Pro'})
  apis: t.list(t.struct({id: t.Str, value: t.Str}))
  theme: t.struct(
    appId: t.enums({cape: 'cape', ezle3: 'ezle3'})
    cssId: t.enums({default: 'default', 'cape-style': 'cape'})
    settings: t.struct(
      homepageId: t.maybe(t.Str)
      js: t.list(t.Str)
      css: t.list(t.Str)
      primaryMenu: t.list(t.struct({link:t.Str, title:t.Str}))
      titleInNav: t.Bool
    )
  )
}
websiteFieldOps = {
  id:
    disabled: true
  title:
    help: 'Name of your new site. Used as the default title.'
    placeholder: 'My awesome website!'
  sld:
    label: 'Subdomain'
    help: 'Pick a subdomain. You can add a custom domain later.'
    placeholder: 'my-site'
    config:
      addonAfter: '.ezle.io'
  vhost:
    label: 'Custom Domain'
  ssFiles:
    legend: 'File Sources'
    help: 'Directory path to use.'
  apis:
    legend: 'Data fields'
    item:
      fields:
        id:
          label: 'Key'
        value:
          type: 'textarea'
          help: '(runflower)'
  theme:
    fields:
      appId:
        label: 'Layout'
        help: 'Select the app that will create the HTML for your site.'
      cssId:
        label: 'Style'
        help: 'Select the style or "theme" that will be used on your site.'
      settings:
        fields:
          homepageId:
            label: 'Homepage data source'
            help: 'Default data or section to use. A directory name or data source like facebook.'
            placeholder: 'homepage'
}

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  handleSubmit: (e) ->
    e.preventDefault()
    {user} = @props
    value = @refs.form.getValue()
    if value
      if value.id
        user.websites.get(value.id).save(value)
      else
        user.websites.create(value)
    console.log 'create/save', value

  render: ->
    {user} = @props
    {siteId} = @context.router.getCurrentParams()

    sites = user.websites.map (site) ->
      info = pick site, 'id', 'facebook', 'plan', 'vhost', 'sld', 'tld', 'title'
      info.id = <Link to="mySites" params={siteId: info.id}>{info.id}</Link>
      if site.ssFiles?.length
        dropbox = find site.ssFiles, (f) ->
          contains(['dbox', 'dropbox'], f.provider)
        if dropbox
          info.dropbox = dropbox.provider+':'+dropbox.prefix
      info.theme = site.theme?.id
      return info

    if siteId and siteInfo = user.websites.get(siteId)
      siteInfo = siteInfo.toJSON()
      # if siteInfo.ssFiles?.length
      #   siteInfo.ssFiles = filter siteInfo.ssFiles, 'provider'
    else
      siteInfo =
        tld: 'ezle.io'
        plan: 'free'
        theme:
          appId: 'cape'
          cssId: 'cape-style'

    siteOptions =
      legend: <h3>{siteInfo.title or siteInfo.id or 'New Website'}</h3>
      fields: websiteFieldOps

    <div className="sites">
      <h3>Websites</h3>
      <Table data={sites} sortable={true} />
      <form onSubmit={@handleSubmit} autoComplete="off">
        <Form ref="form" type={Website} options={siteOptions} value={siteInfo} />
        <button type="submit">Submit</button>
      </form>
    </div>
