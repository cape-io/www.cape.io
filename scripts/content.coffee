fs = require 'fs-extra'
_ = require 'queries'
path = require 'path'

yamlFront = require 'yaml-front-matter' # YAML Front
markdown = require 'marked' # Markdown
mm = require 'marky-mark'

getDirs = (filePath) ->
  dirs = fs.readdirSync(filePath).filter (file) ->
    fs.statSync(filePath+file).isDirectory()
  data = {}
  dirs.forEach (dir) ->
    dirPath = path.join process.cwd(), filePath, dir
    content = mm.parseMatchesSync dirPath, ['**/*.md', '!**/_bio.md']
    data[dir] = _.map content, (model) ->
      yaml = model.meta
      model = _.without model, ['yaml', 'markdown', 'meta']
      _.merge model, yaml
  data

getData = (filePath) ->
  getDirs(filePath).map (dir) ->

    proj = fs.readJsonSync pre+dir+'/index.json'
    proj.key = dir
    images = _.pluck files.files[dir].files, 'path'
    proj.images = images
    proj.mainImg = _.first images
    return proj

module.exports = ->
  database = getDirs('content/')
  database.board = _.sortBy database.board, ['order', 'lastname']
  fs.outputJsonSync 'app/data/content.json', database
