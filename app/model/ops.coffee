Model = require 'ampersand-model'
Collection = require 'ampersand-rest-collection'
FilteredSubcollection = require 'ampersand-filtered-subcollection'
moment = require 'moment'
dateFormat = "MMM Do YYYY"

Op = Model.extend
  props:
    id: 'number'
    created: 'date'
    updated: 'date'
    deadline: 'date'
    preview: 'string'
    title: 'string'
    body: 'string'
    active: 'boolean'
  derived:
    deadlineStr:
      deps: ['deadline']
      fn: ->
        moment(@deadline).format(dateFormat)
    createdStr:
      deps: ['deadline']
      fn: ->
        moment(@created).format(dateFormat)
    fee:
      deps: ['title']
      fn: ->
        @title.indexOf('$$$') > -1

Ops = Collection.extend
  model: Op
  url: '/api/ops/'
  #comparator: 'created'

ops = new Ops()

module.exports = new FilteredSubcollection(ops)
