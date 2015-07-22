React = require 'react/addons'
_ = require 'lodash'

ImageUploading = require './imageUploading'
{processImgFile, uploadFile} = require './process'

module.exports = React.createClass
  getInitialState: ->
    fileHover: false
    fileUploading: null
    progress: 0

  # componentDidMount: ->
  #   # Every time an images changes its src update the view.
  #   app.me.files.on 'add', @handleFileUpload
  #   #app.me.files.on 'change:uploaded', @handleFileUpload
  #   app.me.on 'change:pic', @handleFileUpload
  #
  # componentWillUnmount: ->
  #   app.me.files.off 'add', @handleFileUpload
  #   #app.me.files.off 'change:uploaded', @handleFileUpload
  #   app.me.on 'change:pic', @handleFileUpload
  handleProgress: (progress) ->
    @setState progress: progress

  handleFileUpload: ->
    console.log 'handleFileUpload'
    if @isMounted()
      @setState filesUploading: app.me.files.where(uploaded: false).length
    else
      console.log 'not mounted. wtf error.'

  # This is just to set the hover class.
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

  # Drop or Select
  handleFileSelect: (e) ->
    {onFileUploaded} = @props
    console.log 'handleFileSelect'
    # Disable defaults. Toggle off 'hover' class.
    @handleFileHover(e)

    # Fetch file list object.
    files = e.target.files or e.dataTransfer.files
    maxFiles = 1
    if files.length > maxFiles
      alert 'You are limited to 25 images. Please delete some images before adding more.'
      return

    # Process the first file.
    file = files[0]
    processImgFile {file: file}, ['image/jpg', 'image/jpeg'], (err, fileInfo) =>
      if err
        return console.error err
      @setState fileUploading: fileInfo
      if onFileUploaded
        onFileUploaded(file)
      uploadFile fileInfo.file, app.me.uploadInfo, @handleProgress
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
    {fileHover, fileUploading, progress} = @state
    {imgSrc} = @props

    #   console.log 'files uploading now. show them.'
    #   files = []
    #   app.me.files.where(uploaded: false).forEach (imgUp) ->
    #     #console.log imgUp.fileName
    #     files.push ImageUploading
    #       key: imgUp.fileName
    #       model: imgUp
    #   files = div
    #     className: 'dz-images row',
    #       files
    # else
    #   files = false

    className = "dropzone"
    if fileHover
      className += " alert-info hover"

    if imgSrc
      currentImg = <img src={imgSrc} alt="image" />
    else if fileUploading
      currentImg = <div className="dz-images row"><ImageUploading progress={progress} fileInfo={fileUploading} /></div>
    else
      currentImg = false

    imgTxt = 'Click on the image or drop a new JPG on top of it to replace it.'

    <div className={className} ref="filedrag" onDragOver={@handleFileHover}
      onDragLeave={@handleFileHover} onDrop={@handleFileSelect}
      onClick={@activateFileSelect} id="filedrag">
      {currentImg}
      <p>{imgTxt}</p>
      <input type="file" id="fileselect" ref="fileselect" name="fileselect"
        accept="image/jpg, image/jpeg" onChange={@handleFileSelect}
        style={display:'none'} />
    </div>
