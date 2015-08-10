React = require 'react'
Router = require 'react-router'
{Route, DefaultRoute} = Router

Index = require './view/index'
Login = require './view/user/login'
LoginForm = require './view/user/loginForm'
LoginPending = require './view/user/login'
LoginOk = require './view/user/loginOk'
LoginFail = require './view/user/login'

Contact = require 'cape-react-contact'

Logout = require './view/user/logout'
Page = require './view/page'
Mixer = require './view/mixer/mixer'
EditProfile = require './view/mixer/editProfile'
EditWebsites = require './view/mixer/editWebsites'
EditEvents = require './view/mixer/editEvents'
WebsiteList = require './view/mixer/websiteList'

Ops = require './view/ops'
OpDetail = require './view/opDetail'
# Home = require './view/home/home'
# Domains = require './view/domains/domains'
# Start = require './view/start/start'
# Claim = require './view/claim/claim'

WX = require './view/wx/superior-wind'

module.exports =
  <Route name="app" path="/" handler={Index}>
    <DefaultRoute handler={Page}/>
    <Route name="mixer" handler={Mixer}>
      <Route name="editProfile" path="profile/" handler={EditProfile} />
      <Route name="mySites" path="sites/" handler={WebsiteList} />
      <Route name="site" path="sites/:siteId" handler={EditWebsites} />
      <Route name="myEvents" path="events/" handler={EditEvents} />
    </Route>
    <Route name="login" handler={Login}>
      <DefaultRoute handler={LoginForm} />
      <Route name="checkEmail" path="/login/ok" handler={LoginOk} />
      <Route name="emailPending" path="/login/pending" handler={LoginPending} />
      <Route name="LoginFail" path="/login/fail" handler={LoginFail} />
    </Route>
    <Route name="wx" handler={WX} />
    <Route name="ops" path="ops" handler={Ops} />
    <Route name="opDetail" path="ops/:id" handler={OpDetail} />
    <Route name="contact" handler={Contact} />
    <Route name="logout" path="user/logout/" handler={Logout} />
    <Route name="iframe" path="iframe/:pageId/?:contentId?" handler={Page} />
    <Route name="filter" path=":pageId/filter/:filterType/:filterValue" handler={Page} />
    <Route name="page" path=":pageId/?:contentId?" handler={Page} />
  </Route>
