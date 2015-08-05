_ = require 'lodash'
http = require 'superagent'

humanFileSize = (bytes, si) ->
  thresh = 1024
  if bytes < thresh
    return value: bytes, unit: "B"
  units = ["KB", "MB", "GB"]
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
        alert('You may only upload valid JPG, PNG and GIF image files.
          Changing the filename extension does not change the file type.')
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

  uploadFile: (fileInfo, uploadInfo, metadata, onProgress, onSuccess) ->
    {file, type, humanSize, width, height} = fileInfo
    {cdn, imgix, max_file_size, max_file_count, expires, signature, prefix, url} = uploadInfo
    fieldValue = {}
    cdn = cdn or 'cape-io.imgix.net'
    imgix = imgix or '?w=300&h=300&fit=crop&crop=faces'
    xhr = new XMLHttpRequest()
    handleProgress = (e) ->
      progress = parseInt(e.loaded / e.total * 100)
      if progress % 5 == 0
        onProgress progress
    xhr.upload.addEventListener "progress", handleProgress, false
    xhr.onreadystatechange = (e) =>
      if xhr.readyState is 4
        if xhr.status is 201
          console.log 'Uploaded img to service.'
          # We need to tell the backend to look for this file and add it to the database.
          http.post('/api/file')
            .send(
              fileId: prefix+file.name
              size: "#{humanSize.value} #{humanSize.unit}"
              metadata: metadata
              dimensions:
                type: type
                width: width
                height: height
            )
            .accept('json')
            .end (err, res) =>
              console.error err if err
              if res.body
                fieldValue = _.merge fieldValue, res.body
                if onSuccess
                  onSuccess fieldValue
                console.log fieldValue
          # Remove the old image...
          onProgress 101
          imgSrc = '//'+cdn+prefix+encodeURIComponent(file.name)+imgix
          # Now we test that the image can be loaded and/or resized by Imgix.
          itemImg = new Image()
          itemImg.onload = =>
            console.log 'Resized img.'
            fieldValue.previewUrl = itemImg.src
            if onSuccess
              onSuccess fieldValue
          itemImg.onerror = (e) ->
            alert('There was an error processing your image.
              The image needs to be a JPG or GIF. You could refresh the page
              and see if it shows up in your list. If it shows a broken image
              delete the file and upload with correct file type.')
          itemImg.src = imgSrc
        else
          console.log 'Error uploading file.'

    formData = new FormData()

    #formData.append('redirect', state.redirect)
    formData.append('max_file_size', max_file_size)
    formData.append('max_file_count', max_file_count)
    formData.append('expires', expires)
    formData.append('signature', signature)
    formData.append('file1', file)

    xhr.open 'POST', url, true
    xhr.send formData
