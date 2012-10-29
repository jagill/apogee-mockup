#TestFailures = new Meteor.Collection("test-failures")
#CodeIssues = new Meteor.Collection("code-issues")
#Changes = new Meteor.Collection("changes")

Template.testStatus.testFailures = ->
  TestFailures.find().fetch()

