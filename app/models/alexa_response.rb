class AlexaResponse
  attr_reader :intent

  def initialize(payload:)
    case payload.dig(:request, :intent, :name).downcase
    when "deploy"
      @intent = Intents::Deploy.new(payload: payload)
      DeploymentJob.perform_later(
        source: "alexa",
        application: intent.application,
        environment: intent.environment
      )
    end
  end

  def as_json(options)
    intent.as_json(options)
  end
end
