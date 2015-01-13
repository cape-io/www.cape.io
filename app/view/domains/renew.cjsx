React = require 'react'
{Button, Input, Option} = require 'react-bootstrap'
_ = require 'lodash'

validator = require 'validator'
http = require 'superagent'

module.exports = React.createClass
  getInitialState: ->
    auto: true #auto renewal
    price: 1400
    years: 1
    desc: @getDesc @props.domain, true, 1
    renewed: false

  handleStripeCard: (token) ->
    domain = @props.model
    domainInfo = _.extend domain.toJSON(), @state
    domainInfo.email = token.email
    domainInfo.source = 'simpurl'
    console.log domainInfo
    http.post 'http://kc.l/_stripe/'+token.id
      .send domainInfo
      .set 'Accept', 'application/json'
      .end (res) =>
        if res.ok and res.body
          if res.body.expires and res.body.expires != domain.expires
            domain.expires = res.body.expires
            @setState renewed: true
          else
            # FAIL?!?
            console.log 'FAIL', res.body
    console.log token

  componentDidMount: ->
    @handler = StripeCheckout.configure
      #key: "pk_test_ngNDwpo48cw9L6PQeiZL59w5"
      key: "pk_live_gnmGNwWeIYmg8GnpzX3onnto"
      # image: "/square-image.png"
      token: @handleStripeCard
    window.addEventListener 'popstate', @handleNavAway, false
    history.pushState {}, ''

  handleNavAway: (e) ->
    console.log 'popstate'
    @handler.close()

  componentWillUnmount: ->
    window.removeEventListener 'popstate', @handleNavAway,

  getDesc: (domain, auto, years) ->
    if auto
      "Renew #{domain} every #{years} yr(s)."
    else
      "Extend #{domain} #{years} more yr(s)."

  handleInput: ->
    auto = @refs.auto.getChecked()
    years = @refs.years.getValue()
    pricePerYr = 1400
    price = pricePerYr * parseInt(years)

    @setState
      auto: auto
      price: price
      years: years
      desc: @getDesc auto, years

  handleClick: ->
    {domain} = @props
    {auto, years, price} = @state
    @handler.open
      name: 'Sundays Energy'
      description: @getDesc domain, auto, years
      amount: price
      zipCode: true
    return

  render: ->
    {domain} = @props
    {price, auto, years} = @state
    btnTxt = "Pay $#{price/100} by Card"
    <form>
      <h3>{@getDesc domain, auto, years}</h3>
      <Input type="checkbox" ref="auto" label="Auto Renew" checked={auto} onChange={@handleInput} />
      <Input type="select" ref="years" label='Years' defaultValue="select" onChange={@handleInput} selected={years+''}>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="5">5</option>
        <option value="10">10</option>
      </Input>
      <Button bsStyle="primary" onClick={@handleClick}>{btnTxt}</Button>
    </form>
