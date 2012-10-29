#TestFailures = new Meteor.Collection("test-failures")
#CodeIssues = new Meteor.Collection("code-issues")
#Changes = new Meteor.Collection("changes")

Template.testStatus.testFailures = ->
  TestFailures.find().fetch()

Template.codeIssues.codeIssues = ->
  CodeIssues.find({}, {sort: {severity: 1}}).fetch()
