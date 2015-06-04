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
  email: t.Str
  sld: t.Str
  vhost: t.maybe(t.Str)
  ssFiles: t.list(FileSource)
  facebook: t.maybe(t.Str)
  instagram: t.maybe(t.Str)
  plan: t.enums(
    free: 'Free'
    light: 'Light'
    basic: 'Basic'
    advanced: 'Advanced'
    pro: 'Pro'
  )
  apis: t.list(t.struct({id: t.Str, value: t.Str}))
  theme: t.struct(
    appId: t.enums({cape: 'cape', ezle3: 'ezle3'})
    cssId: t.enums(
      default: 'default'
      'cape-style': 'CAPE'
      'ookb-style': 'OOKB'
      'fbpl-bgbleed': 'Single Page w/ Background Images'
      'hg-style': 'Hunting Ground'
      'acf-style': 'American Composers Forum'
      'bbg-style': 'Baltimore Bartender'
      'ppf-style': 'Prairiepasque'
    )
    settings: t.struct(
      hasLogin: t.Bool
      pagesMenu: t.Bool
      fluid: t.Bool
      homepageId: t.maybe(t.Str)
      defaultDisplay: t.maybe(t.enums(
        imageGrid: 'Image Grid'
        slideShow: 'Slideshow'
        titleList: 'List of Titles'
      ))
      imageGrid: t.struct(
        width: t.maybe(t.Num)
        height: t.maybe(t.Num)
        fit: t.maybe(t.Str)
        hideInfo: t.Bool
      )
      slideShow: t.struct(
        slideDuration: t.maybe(t.Num)
        width: t.maybe(t.Num)
      )
      titleList: t.struct(
        dateFormat: t.maybe(t.Str)
      )
      #displays: t.maybe(t.Str)
      js: t.list(t.Str)
      css: t.list(t.Str)
      primaryMenu: t.list(t.struct({link:t.Str, title:t.Str}))
      titleInNav: t.Bool
      aboutInHeader: t.Bool
      missionInHeader: t.Bool
      taglineInHeader: t.Bool
      singlePage: t.Bool
      bgImgs: t.Bool
      filters: t.list(
        t.struct(
          prop: t.Str
          filters: t.list(t.struct(
            field: t.Str
            title: t.Str
            orderBy: t.enums({valueUp: 'Asec value', valueDown: 'Desc Value', countDown: 'Qty down', countUp: 'Qty up'})
          ))
        )
      )
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
        label: 'Structure'
        help: 'Select the app that will create the HTML for your site.'
      cssId:
        label: 'Layout and Style'
        help: 'Select the style or "theme" that will be used on your site.'
      settings:
        fields:
          fluid:
            help: 'Select to give the container a "container-fluid" class. Default is "container".'
          display:
            help: 'yaml'
          homepageId:
            label: 'Homepage data source'
            help: 'Default data or section to use. A directory name or data source like facebook.'
            placeholder: 'homepage'
          imageGrid:
            fields:
              fit:
                placeholder: 'crop'
          slideShow:
            fields:
              slideDuration:
                help: 'Time in ms.'
                placeholder: '4000'
          titleList:
            fields:
              dateFormat:
                placeholder: 'DD MMM YYYY'
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
      @context.router.transitionTo('editProfile')
    else
      alert('Please review for errors')
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
          settings:
            defaultDisplay: 'imageGrid'
            css: ['/theme/app.css']
            js: ['/theme/app.js']
    siteOptions =
      legend: <h3>{siteInfo.title or siteInfo.id or 'New Website'}</h3>
      fields: websiteFieldOps

    <div className="sites">
      <h3>Websites</h3>
      <div className="skinny scrollable">
        <Table data={sites} sortable={true} />
      </div>
      <form onSubmit={@handleSubmit} autoComplete="off">
        <Form ref="form" type={Website} options={siteOptions} value={siteInfo} />
        <button className="big clickable" type="submit">Submit</button>
      </form>
    </div>
