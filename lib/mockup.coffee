insertTF = (message) ->
  TestFailures.insert({message:message})

removeTF = (id) ->
  TestFailures.remove(id)

clearTF = ->
  TestFailures.remove({})

insertCI = (severity, message) ->
  switch severity
    when 1 then sevClass = 'error'
    when 2 then sevClass = 'warning'
    when 3 then sevClass = 'info'
  CodeIssues.insert({severity:severity, severityClass:sevClass, message:message})

removeCI = (id) ->
  CodeIssues.remove(id)

clearCI = ->
  CodeIssues.remove({})

insertChange = (time, username, hash, shortDesc) ->
  Changes.insert({whenCommitted:time, username:username, hash:hash, shortDescription:shortDesc})

removeChange = (id) ->
  Changes.remove(id)

clearChange = ->
  Changes.remove({})

insertFile = (path, isDir, body) ->
  file = {path:path, projectId:"123ADF", isDir:isDir, body:body}
  file = processFile(file)
  Files.insert(file)


