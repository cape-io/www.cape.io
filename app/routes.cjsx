React = require 'react'
Router = require 'react-router'
{Route, DefaultRoute} = Router

Index = require './view/index'
Page = require './view/page'

# Home = require './view/home/home'
# Domains = require './view/domains/domains'
# Start = require './view/start/start'
# Claim = require './view/claim/claim'

module.exports =
  <Route name="app" path="/" handler={Index}>
    <DefaultRoute handler={Page}/>
    <Route name="page" path=":pageId/?:contentId?" handler={Page} />
  </Route>
