class Intents::Help
  include Intent

  attr_reader :application, :environment

  def initialize(payload:)
    @application = payload.dig(:request, :intent, :slots, :application, :value)
    @environment = payload.dig(:request, :intent, :slots, :environment, :value)
  end

  def output_text
    text = "You can tell Alexa to ask Deploy Bot to deploy your applications.\n"
    text << "For example, you can say:\n"
    text << "Alexa, ask Deploy Bot to deploy steve to production\n"
    text << "or\n"
    text << "Alexa, tell Deploy Bot to deploy hal to staging\n"
    text
  end
end
