class AlexaResponse
  attr_reader :intent

  def initialize(payload:)
    name = payload.dig(:request, :intent, :name)
    return Intents::Unknown.new(payload: payload) unless name

    case name.downcase
    when "deploy"
      @intent = Intents::Deploy.new(payload: payload)
      DeploymentJob.perform_later(
        source: "alexa",
        application: intent.application,
        environment: intent.environment
      )
    when "threat"
      @intent = Intents::Threat.new(payload: payload)
    end
  end

  def as_json(options)
    intent.as_json(options)
  end
end
