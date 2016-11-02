App.deployment = App.cable.subscriptions.create "DeploymentChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
  deploy: (text) ->
    @perform("deploy", text: text)
