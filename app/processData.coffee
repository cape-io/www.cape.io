_ = require 'lodash'
Collection = require 'ampersand-collection'

module.exports = (data) ->
  data.currentYear = new Date().getFullYear()
  domains = _.map data.domains, (domain) ->
    domain.id = domain.sld + '.' + domain.tld
    return domain
  data.domains = new Collection domains

  return data
