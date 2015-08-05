React = require 'react/addons'
_ = require 'lodash'
Formsy = require 'formsy-react'

ImageUploading = require './imageUploading'
{processImgFile, uploadFile} = require './process'

module.exports = React.createClass

  mixins: [Formsy.Mixin]

  getInitialState: ->
    fileHover: false
    fileUploading: null
    progress: 0
    errorMsg: null
    warningMsg: null

  handleProgress: (progress) ->
    @setState progress: progress

  handleUploaded: (imgInfo) ->
    console.log 'handleUploaded'
    if imgInfo.id and imgInfo.previewUrl
      console.log 'imgResized'
      @setValue _.pick(imgInfo, 'id', 'path', 'previewUrl')
      @setState
        fileUploading: null
        errorMsg: null
        warningMsg: null

  # This is just to (un)set the hover class.
  handleFileHover: (e) ->
    if e.preventDefault then e.preventDefault()
    if e.stopPropagation then e.stopPropagation()
    if e.type == 'dragover'
      e.dataTransfer.dropEffect = 'copy'
      if not @state.fileHover
        @setState fileHover: true
    else if @state.fileHover == true
      @setState fileHover: false
    return

  validate: ->
    @state.errorMsg is null
    # {qty, id, type, bytes, previewUrl, sourceUrl, path} = @getValue()
    #     if files.length > maxFiles
    #       alert 'Please only upload one image at a time.'

  # Drop or Select
  handleFileSelect: (e) ->
    {metadata} = @props
    console.log 'handleFileSelect'
    # Disable defaults. Toggle off 'hover' class.
    @handleFileHover(e)

    # Fetch file list object.
    files = e.target.files or e.dataTransfer.files
    maxFiles = 1
    if files.length > maxFiles
      warningMsg = 'Please only upload one image at a time.'

    # Process the first file.
    file = files[0]
    processImgFile {file: file}, ['image/jpg', 'image/jpeg'], (err, fileInfo) =>
      if err
        return @setState {errorMsg: err, warningMsg: warningMsg}
      @setState
        fileUploading: fileInfo
        warningMsg: warningMsg
      uploadFile fileInfo, app.me.uploadInfo, metadata, @handleProgress, @handleUploaded
      # fileName = app.me.uploadInfo.prefix.substr(1)+file.name
      # console.log file.type
      # app.me.files.add
      #   metadata: {id: fileName, profilePic: true, title: 'Profile Picture'}
      #   file: file
      #   fileName: fileName,
      #     parse: true
    # else
    #   console.log file.type
    #   alert 'Please upload JPGs or GIFs, not a '+ file.type.split('/')[1].toUpperCase() + '.
    #     The system does not handle image files of this type. Please save this as a JPG from
    #     the program you used to create this. Ask a friend if you need help.'
    return

  activateFileSelect: ->
    @refs.fileselect.getDOMNode().click()

  render: ->
    {fileHover, fileUploading, progress, errorMsg, warningMsg} = @state
    className = "dropzone"
    if fileHover
      className += " alert-info hover"
    imgInfo = @getValue()
    if fileUploading
      currentImg =
        <div className="dz-images row">
          <ImageUploading progress={progress} fileInfo={fileUploading} width="300" />
        </div>
    else if imgInfo?.previewUrl
      currentImg =
        <div className="dz-image"><img src={imgInfo.previewUrl} alt="image" /></div>
    else
      currentImg = false

    if errorMsg
      txtClassName = 'error'
      imgTxt = errorMsg
    else if warningMsg
      txtClassName = 'warning'
      imgTxt = warningMsg
    else
      txtClassName = 'help'
      imgTxt = 'Click on the image or drop a new JPG on top of it to replace it.'

    <div className={className} ref="filedrag" onDragOver={@handleFileHover}
      onDragLeave={@handleFileHover} onDrop={@handleFileSelect}
      onClick={@activateFileSelect} id="filedrag">
      {currentImg}
      <p className={txtClassName}>{imgTxt}</p>
      <input type="file" id="fileselect" ref="fileselect" name="fileselect"
        accept="image/jpg, image/jpeg" onChange={@handleFileSelect}
        style={display:'none'} />
    </div>
