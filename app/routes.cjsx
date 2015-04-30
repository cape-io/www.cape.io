React = require 'react'
Router = require 'react-router'
{Route, DefaultRoute} = Router

Index = require './view/index'
Login = require './view/user/login'
Logout = require './view/user/logout'
Page = require './view/page'
Mixer = require './view/mixer/mixer'
EditProfile = require './view/mixer/editProfile'
EditWebsites = require './view/mixer/editWebsites'
# Home = require './view/home/home'
# Domains = require './view/domains/domains'
# Start = require './view/start/start'
# Claim = require './view/claim/claim'

module.exports =
  <Route name="app" path="/" handler={Index}>
    <DefaultRoute handler={Page}/>
    <Route name="mixer" handler={Mixer}>
      <Route name="editProfile" path="profile/" handler={EditProfile} />
      <Route name="mySites" path="sites/:siteId?" handler={EditWebsites} />
    </Route>
    <Route name="login" path="user/login/" handler={Login} />
    <Route name="logout" path="user/logout/" handler={Logout} />
    <Route name="filter" path=":pageId/filter/:filterType/:filterValue" handler={Page} />
    <Route name="page" path=":pageId/?:contentId?" handler={Page} />
  </Route>
