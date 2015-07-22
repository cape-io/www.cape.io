_ = require 'lodash'

humanFileSize = (bytes, si) ->
  thresh = 1024
  if bytes < thresh
    return value: bytes, unit: "B"
  units = ["KiB", "MiB", "GiB"]
  u = -1
  loop
    bytes /= thresh
    ++u
    break unless bytes >= thresh
  return value: bytes.toFixed(1), unit: units[u]

module.exports =
  humanFileSize: humanFileSize

  processImgFile: (fileInfo, validImgTypes, cb) ->
    {file, md5} = fileInfo

    if md5
      fileInfo.uploaded = true
      fileInfo.progress = 100
      return cb(fileInfo)

    unless file
      return cb('Missing file')
    fileInfo.name = file.name
    fileInfo.bytes = file.size
    fileInfo.type = file.type
    fileInfo.image = fileInfo.type.indexOf('image') is 0
    fileInfo.humanSize = humanFileSize(fileInfo.bytes)

    unless fileInfo.image
      return cb('Not of type image.')

    if _.isArray validImgTypes
      unless _.contains validImgTypes, fileInfo.type
        return cb('Not a valid image type.')

    reader = new FileReader()
    reader.onload = (e) =>
      img = new Image
      img.onerror = (err) ->
        alert('Hey, you may only upload valid JPG, PNG and GIF image files.
          Changing the file extension does not change the file type.
          Try again.')
        cb(err)
      img.onload = ->
        console.log img.width, img.height
        fileInfo.width = img.width
        fileInfo.height = img.height
        if 3000000 > fileInfo.bytes
          fileInfo.fileData = e.target.result
        cb(null, fileInfo)
      img.src = reader.result
      return
    reader.readAsDataURL fileInfo.file

  uploadFile: (file, uploadInfo, onProgress) ->
    xhr = new XMLHttpRequest()
    handleProgress = (e) ->
      progress = parseInt(e.loaded / e.total * 100)
      if progress % 5 == 0
        onProgress progress
    xhr.upload.addEventListener "progress", handleProgress, false
    xhr.onreadystatechange = (e) =>
      if xhr.readyState is 4
        if xhr.status is 201
          console.log 'uploaded img'
          # itemImg = new Image()
          # itemImg.onload = =>
          #   console.log 'resized img'
          #   @save()
          #   if @metadata.profilePic == true
          #     me = @collection.parent
          #     # Delete old profile image.
          #     if me.picFileName
          #       picModel = @collection.get(me.picFileName)
          #       if picModel then picModel.destroy()
          #     # Save new file info to profile.
          #     me.pic = itemImg.src
          #     me.picFileName = @fileName
          #     me.save()
          #
          # itemImg.onerror = (e) ->
          #   alert('There was an error processing your image.
          #     The image needs to be a JPG or GIF. You could refresh the page
          #     and see if it shows up in your list. If it shows a broken image
          #     delete the file and upload with correct file type.')
          # itemImg.src = @createSrcUrl()
        else
          console.log 'Error uploading file.'

    formData = new FormData()
    up = uploadInfo
    #formData.append('redirect', @state.redirect)
    formData.append('max_file_size', up.max_file_size)
    formData.append('max_file_count', up.max_file_count)
    formData.append('expires', up.expires)
    formData.append('signature', up.signature)
    formData.append('file1', file)

    xhr.open 'POST', up.url, true
    xhr.send formData
