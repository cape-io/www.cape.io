_ = require 'lodash'
Collection = require 'ampersand-collection'

module.exports = (data) ->
  data.db = data.db or {}
  {db, theme} = data
  {css, js, settings} = theme
  {author, description, title} = db

  meta = [
    ['viewport', 'width=device-width, initial-scale=1']
    ['generator', 'CAPE.io, v5.0.1 see www.cape.io']
  ]
  if _.isString author
    meta.push ['author', author]
  if description
    meta.push ['description', description]

  data.theme.meta = meta
  title = data.title = db.title or '[title]'

  data.currentYear = new Date().getFullYear()

  data.filterIndex = {}
  if settings?.filters
    _.each settings.filters, (fltr) ->
      data.filterIndex[fltr.prop] = {filters: fltr.filters, option: {}}
      _.each fltr.filters, (fop) ->
        data.filterIndex[fltr.prop].option[fop.field] = {}

  addFilterOpt = (prop, fieldId, filtOpt) ->
    # Add value to option index.
    if data.filterIndex[prop].option[fieldId][filtOpt]
      data.filterIndex[prop].option[fieldId][filtOpt]++
    else
      data.filterIndex[prop].option[fieldId][filtOpt] = 1
  if settings.pagesMenu
    data.pages = []

  if db
    data.startYear = db.startYear or db.since
    # For each key in the database.
    _.each db, (val, key) ->
      {contents, wufoo, filename, content, title} = val
      if content and settings.pagesMenu
        data.pages.push {link: key, title: title or filename}
      unless contents
        return
      # If the value has a contents property
      # Create a contentsIndex.
      contentsIndex = {}
      lastIndex = contents.length - 1
      _.each contents, (item, i) ->
        {filename, path, slug} = item
        # Where the key is slug or path or filename.
        contentId = slug or path or filename

        item._sectionId = filename
        prevIndex = if i is 0 then lastIndex else i - 1
        item.prevIndex = prevIndex
        item._previous = contents[prevIndex]
        item.first = i is 0

        nextIndex = if i is lastIndex then 0 else i + 1
        item.prevIndex = prevIndex
        item._next = contents[nextIndex]
        item.last = i is lastIndex

        # Filters
        if data.filterIndex[key]
          # Check content against every filter.
          _.each data.filterIndex[key].filters, (fltr) ->
            # Content has a field that matches this filter.
            if item[fltr.field]
              filterOpt = item[fltr.field]
              if _.isArray filterOpt
                _.each filterOpt, (fltrOptItem) ->
                  addFilterOpt key, fltr.field, fltrOptItem
              else
                addFilterOpt key, fltr.field, filterOpt

        if val[contentId]
          item.data = val[contentId]
        data.db[key].contents[i] = item
        data.db[key][contentId] = data.db[key].contents[i]

      # Add wufoo information to contact page.
      if key is 'contact' and wufoo
        data.db[key].wufoo = wufoo

  # cape.io specific...
  domains = _.map data.domains, (domain) ->
    domain.id = domain.sld + '.' + domain.tld
    return domain
  data.domains = new Collection domains

  return data
