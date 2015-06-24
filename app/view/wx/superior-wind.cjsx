React = require 'react'
_ = require 'lodash'

windUrl = "http://www.glerl.noaa.gov/res/glcfs/ncast/swn-"
windExt = ".gif"
windPrev = 49
windFuture = 121

wind = "http://www.glerl.noaa.gov/res/glcfs/ncast/swn-48.gif"
wind = "http://www.glerl.noaa.gov/res/glcfs/fcast/swn+00.gif"
wind = "http://www.glerl.noaa.gov/res/glcfs/fcast/swn+120.gif"
us1 = "http://www.wpc.ncep.noaa.gov/sfc/usfntsfcwbg.gif"

gust = "http://www.crh.noaa.gov/images/greatlakes/ndfd/SUP/dynamic/WindGustMarine_2015062203_sup.png"
gust = "http://www.crh.noaa.gov/images/greatlakes/ndfd/SUP/dynamic/WindGustMarine_2015062700_sup.png"

buildUrls = (url, fromNumber, toNumber, ext) ->
  _.map [fromNumber...toNumber], (num) ->
    numString = _.padLeft(num, 2, '0')
    url+numString+ext


module.exports = React.createClass

  render: ->
    imgs = buildUrls(windUrl, windPrev, 0, windExt)
      .concat(buildUrls(windUrl, 0, windFuture, windExt))

    <ul>
      {
        _.map imgs, (src, i) ->
          <li key={i}><img src={src} alt="wind" /></li>
      }
    </ul>
