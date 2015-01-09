React = require 'react'
Router = require 'react-router'
{Route, DefaultRoute} = Router

Index = require './view/index'
Home = require './view/home/home'
Domains = require './view/domains/domains'

module.exports =
  <Route name="app" path="/" handler={Index}>
    <Route name="domains" path="/domains/" handler={Domains} />
    <Route name="usrProfile" path="/domains/:uid/?:img?" handler={Domains} />
    <DefaultRoute handler={Home}/>
  </Route>
