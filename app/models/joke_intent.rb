class JokeIntent
  attr_reader :adjective

  def initialize(payload:)
    @adjective = payload.dig(:request, :intent, :slots, :adjective, :value)
  end

  def as_json(options)
    {
      version: "1.0",
      response: {
        outputSpeech: {
          type: "PlainText",
          text: "HAL says your face is #{adjective}"
        },
        shouldEndSession: true
      }
    }
  end
end
