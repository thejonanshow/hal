class AlexaResponse
  attr_reader :intent

  def initialize(payload:)
    case payload.dig(:request, :intent, :name)
    when "AMAZON.HelpIntent"
      @intent = Intents::Help.new(payload: payload)
    when "deploy"
      @intent = Intents::Deploy.new(payload: payload)
    end
  end

  def as_json(options)
    intent.as_json(options)
  end
end
