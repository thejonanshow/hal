require 'active_support/concern'

module Intent
  extend ActiveSupport::Concern

  def as_json(options)
    unless defined?(:output_text)
      raise NotImplementedError.new("All intents must implement output_text")
    end

    {
      version: "1.0",
      response: {
        outputSpeech: {
          type: "PlainText",
          text: output_text
        },
        shouldEndSession: true
      }
    }
  end
end
