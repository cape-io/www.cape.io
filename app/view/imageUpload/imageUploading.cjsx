React = require 'react'

module.exports = React.createClass
  # getInitialState: ->
  #   progress: progress
  #   src: src
  #
  # handleProgress: (model, progress) ->
  #   if progress % 5 == 0
  #     @setState progress: progress
  #
  # handleSrcChange: (model, src) ->
  #   if src != @state.src
  #     @setState src: src

  render: ->
    {width, progress, fileInfo} = @props
    {humanSize, fileData} = fileInfo
    width = width or '150'
    progressStr = progress+'%'

    <div className="dz-preview dz-processing dz-image-preview col-md-2">
      <div className="dz-details">
        <div className="dz-filename"><span>{name}</span></div>
        <img alt={name} src={fileData} width={width} />
        <div className="dz-size">
          <span className="dz-size-value">{humanSize.value}</span>
          <span className="dz-size-unit">{humanSize.unit}</span>
        </div>
      </div>
      <div className="dz-progress progress">
        <div className="progress-bar" role="progressbar" style={width: progressStr}
          aria-valuenow={progress} aria-valuemin="0" aria-valuemax="100">
          {progressStr}
        </div>
      </div>
      <button role="button" className="dz-remove">Remove File</button>
    </div>
