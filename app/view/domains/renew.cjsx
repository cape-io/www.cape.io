React = require 'react'
{Button, Input, Option} = require 'react-bootstrap'

validator = require 'validator'

module.exports = React.createClass
  getInitialState: ->
    auto: true #auto renewal
    price: 1400
    years: 1
    desc: @getDesc @props.domain, true, 1

  componentDidMount: ->
    @handler = StripeCheckout.configure
      key: "pk_test_ngNDwpo48cw9L6PQeiZL59w5"
      # image: "/square-image.png"
      token: (token) ->
        console.log token
    window.addEventListener 'popstate', @handleNavAway, false
    history.pushState {}, ''

  handleNavAway: (e) ->
    console.log 'popstate'
    @handler.close()

  componentWillUnmount: ->
    window.removeEventListener 'popstate', @handleNavAway,

  getDesc: (domain, auto, years) ->
    if auto
      desc = "Renew #{domain} every #{years} yr(s)."
    else
      desc = "Extend #{domain} #{years} more yr(s)."

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
      <Input type="checkbox" ref="auto" label="Auto Renew" checked={auto} onChange={@handleInput} />
      <Input type="select" ref="years" label='Years' defaultValue="select" onChange={@handleInput} selected={years+''}>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="5">5</option>
        <option value="10">10</option>
      </Input>
      <h3>{@getDesc domain, auto, years}</h3>
      <Button bsStyle="primary" onClick={@handleClick}>{btnTxt}</Button>
    </form>
