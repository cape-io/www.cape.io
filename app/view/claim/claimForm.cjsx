React = require 'react'
{Button, Alert, Well, Row, Col} = require 'react-bootstrap'
_ = require 'lodash'

http = require 'superagent'

module.exports = React.createClass
  getInitialState: ->
    price: 5000
    desc: 'CAPE Basic - 1yr'
    years: 1
    success: false

  handleStripeCard: (token) ->
    domain = @props.model
    domainInfo = _.extend _.omit(domain, 'collection'), @state
    domainInfo.email = token.email
    domainInfo.source = 'cape.io'
    domainInfo.service = 'cape-basic'
    #console.log domainInfo
    http.post 'https://social.cape.io/_stripe/'+token.id
      .send domainInfo
      .set 'Accept', 'application/json'
      .end (res) =>
        if res.ok and res.body
          if res.body.paymentId
            @setState success: true
          else
            # FAIL?!?
            console.log 'FAIL', res.body
    console.log token

  componentDidMount: ->
    @handler = StripeCheckout.configure
      #key: "pk_test_ngNDwpo48cw9L6PQeiZL59w5"
      key: "pk_live_JXgjo0UEl4IbuPaxINj1ob9n"
      # image: "/square-image.png"
      token: @handleStripeCard
    window.addEventListener 'popstate', @handleNavAway, false
    history.pushState {}, ''

  handleNavAway: (e) ->
    console.log 'popstate'
    @handler.close()

  componentWillUnmount: ->
    window.removeEventListener 'popstate', @handleNavAway,

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
    {desc, price} = @state
    @handler.open
      name: 'Sundays Energy'
      description: desc
      amount: price
      zipCode: true
    return

  render: ->
    {domain} = @props
    {price, desc, success} = @state

    btnTxt = "Pay $#{price/100} by Card"
    description = "Start your year of CAPE Basic service now!"
    thanksTxt = "Thanks for joining! Your site will be activated shortly."
    includes = "Price includes the cost of domain name registration."
    if success
      output = <Alert bsStyle="success">{thanksTxt}</Alert>
    else
      output =
        <Well>
          <p className="lead">{description}</p>
          <p>{includes}</p>
          <Button bsStyle="primary" onClick={@handleClick}>{btnTxt}</Button>
        </Well>

    <Row className="claim">
      <Col xs={8} md={8} mdOffset={2}>
        {output}
      </Col>
    </Row>
