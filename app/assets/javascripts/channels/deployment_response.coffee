App.deployment_response = App.cable.subscriptions.create "DeploymentResponseChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
    message_received(data["text"])
