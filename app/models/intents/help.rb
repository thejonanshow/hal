class Intents::Help
  include Intent

  def initialize(payload:)
  end

  def output_text
    text = "You can tell Alexa to ask Deploy Bot to deploy your applications.\n"
    text << "For example, you can say:\n"
    text << "Alexa, ask Deploy Bot to deploy steve to production.\n"
    text << "or\n"
    text << "Alexa, tell Deploy Bot to deploy hal to staging\n"
    text
  end
end
