class Intents::Deploy
  include Intent

  attr_reader :application, :environment

  def initialize(payload:)
    @application = payload.dig(:request, :intent, :slots, :application, :value)
    @environment = payload.dig(:request, :intent, :slots, :environment, :value)
  end

  def output_text
    "Deploy Bot has deployed #{application} to #{environment}"
  end
end
