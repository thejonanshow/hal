class DeploymentJob < ApplicationJob
  queue_as :default

  def perform(application, environment)
    status = Clients::Heroku.deploy(
      application: application,
      environment: environment
    )

    reply = "I've finished deploying #{application} to #{environment}. "
    reply << "The deployment #{status}."
    ActionCable.server.broadcast("deployment_responses", text: reply)
  end
end
