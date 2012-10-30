DEFAULT_FILE_NAME = "Select a file"
DEFAULT_PROJECT_NAME = "New Project"
ROOT_DIR_NAME = "the root directory."


Template.fileTree.files = ->
  constructFileTree Files.find().fetch()

Template.fileEntry.isSelected = ->
  return Session.equals("currentFileId", this._id)

Template.fileEntry.isOpen = ->
  console.log("Checking isOpen for", this)
  return this.isDir && isDirOpen(this._id)

Template.fileEntry.fileEntryClass = ->
  clazz = "fileTree-item"
  if this.isDir
    clazz += " directory " + if isDirOpen(this._id) then "open" else "closed"
  else
    clazz += " file"
  if this.parents.length
    clazz += " level" + this.parents.length
  clazz += " selected" if Session.equals("currentFileId", this._id)
  return clazz


Template.fileEntry.events(
  'click li.fileTree-item' : (event) ->
    console.log "Got click event", event
    event.preventDefault()
    event.stopPropagation()
    event.stopImmediatePropagation()
    fileId = event.currentTarget.id
    Session.set("currentFileId", fileId)
    file = Files.findOne(_id:fileId)
    if file.isDir
      toggleDir fileId
    else
      Session.set("lastTextFileId", fileId)
  )

Template.fileView.rendered = ->
  0

Template.fileView.fileName = ->
  fileId = Session.get("lastTextFileId")
  name = if fileId then Files.findOne(fileId)?.name else null
  name ?= DEFAULT_FILE_NAME
  return name

Template.fileTree.currentFileName = ->
  fileId = Session.get("currentFileId")
  name = if fileId then Files.findOne(fileId)?.name else null
  name ?= "selected file."
  return name

Template.fileTree.currentDirName = ->
  fileId = Session.get("currentFileId")
  file = if fileId then Files.findOne(fileId) else null
  name = null
  if file?
    if file.isDir
      name = file.name
    else if file.parents.length
      name = file.parents[file.parents.length-1]
  name ?= ROOT_DIR_NAME
  return name

