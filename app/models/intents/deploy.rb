class Intents::Deploy
  include Intent

  attr_reader :application, :environment

  def initialize(payload:)
    @application = payload.dig(:request, :intent, :slots, :application, :value)
    @environment = payload.dig(:request, :intent, :slots, :environment, :value)
  end

  def output_text
    text = "HAL has deployed #{application} to #{environment}, hypothetically."
    text << "I'm not actually able to give you information about whether or not "
    text << "the deploy was successful because I can't deliver messages to you "
    text << "unprompted. That would actually be a terrible feature, imagine if "
    text << "LinkedIn could send voice messages to your living room."
  end
end
