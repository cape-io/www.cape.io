React = require 'react'

module.exports = React.createClass

  mountForm: ->
    {hash} = @props
    varId = "wufooForm#{hash}"
    try
      unless document[varId]
        document[varId] = new WufooForm()
        document[varId].initialize(@options())
      document[varId].display()
    catch error
      console.error 'wufoo error', error

  insertJs: (d, s, id, url) ->
    js = undefined
    fjs = d.getElementsByTagName(s)[0]
    if d.getElementById(id)
      @mountForm()
      return
    js = d.createElement(s)
    js.id = id
    js.src = url
    js.onload = @mountForm
    fjs.parentNode.insertBefore js, fjs
    console.log 'insert wufoo js'
    return

  options: ->
    {subdomain, hash, height, header} = @props
    userName: subdomain
    formHash: hash
    autoResize: true
    height: height or '976'
    async: true
    host: 'wufoo.com'
    header: header or 'hide'
    ssl: true

  componentDidMount: ->
    @insertJs document, 'script', 'wufoo-js', '//www.wufoo.com/scripts/embed/form.js'

  render: ->
    {hash, subdomain} = @props
    unless hash and subdomain
      console.log 'no wufoo info in data'
      return false

    divId = "wufoo-#{hash}"
    link = "https://#{subdomain}.wufoo.com/forms/#{hash}/"

    <div className="contact-form">
      <div id={divId}>
        <a href={link}> Fill out our contact form here. </a>
      </div>
    </div>
