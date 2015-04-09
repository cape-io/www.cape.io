Collection = require 'ampersand-collection'
Model = require 'ampersand-model'

Website = Model.extend
  urlRoot: '/api/website'
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

module.exports = Collection.extend
  model: Website
