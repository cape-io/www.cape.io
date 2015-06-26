React = require 'react'
_ = require 'lodash'

Slideshow = require '../slideshow'

windUrl = "http://www.glerl.noaa.gov/res/glcfs/"
windExt = ".gif"
windPrev = 48
windFuture = 121


us1 = "http://www.wpc.ncep.noaa.gov/sfc/usfntsfcwbg.gif"
gust = "http://www.crh.noaa.gov/images/greatlakes/ndfd/SUP/dynamic/WindGustMarine_2015062203_sup.png"
gust = "http://www.crh.noaa.gov/images/greatlakes/ndfd/SUP/dynamic/WindGustMarine_2015062700_sup.png"

buildUrls = (url, fromNumber, toNumber, ext) ->
  _.map [fromNumber...toNumber], (num) ->
    numString = _.padLeft(num, 2, '0')
    url+numString+ext


module.exports = React.createClass

  render: ->
    imgs = buildUrls(windUrl+'ncast/swn-', windPrev, 0, windExt)
      .concat(buildUrls(windUrl+'fcast/swn+', 0, windFuture, windExt))

    <Slideshow images={imgs} slideDuration={400} width={820} />
