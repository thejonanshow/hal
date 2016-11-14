App.deployment_response = App.cable.subscriptions.create "DeploymentResponseChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
    language = data["lang"]
    language ||= "en-US"
    message_received(data["text"], language)
