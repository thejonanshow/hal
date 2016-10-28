class AlexaResponse
  attr_reader :intent

  def initialize(payload:)
    case payload.dig(:request, :intent, :name)
    when "deploy"
      @intent = DeployIntent.new(payload: payload)
    when "jokes"
      @intent = JokeIntent.new(payload: payload)
    end
  end

  def as_json(options)
    intent.as_json(options)
  end
end
