# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DeploymentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "deployments"
  end

  def receive(data)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def deploy(data)
    Rails.logger.info data
    ActionCable.server.broadcast("deployment_responses", text: "I have deployed Steve to production.")
  end
end
