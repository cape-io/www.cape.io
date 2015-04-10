Collection = require 'ampersand-rest-collection'
Model = require 'ampersand-model'

Website = Model.extend
  props:
    api: 'object'
    facebook: 'string'
    id: 'string'
    pathIndex: 'object'
    plan: 'string'
    ssFiles: 'array'
    sld: 'string'
    tld: 'string'
    title: 'string'
    theme: 'object'
    userId: 'string'
    vhost: 'string'
  extraProperties: 'allow'

module.exports = Collection.extend
  model: Website
  url: '/api/website'
