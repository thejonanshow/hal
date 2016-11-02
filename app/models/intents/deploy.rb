class Intents::Deploy
  include Intent

  attr_reader :application, :environment

  def initialize(payload:)
    @application = payload.dig(:request, :intent, :slots, :application, :value).downcase
    @environment = payload.dig(:request, :intent, :slots, :environment, :value).downcase
  end

  def output_text
    valid_application = Deployment.applications.include? application
    valid_environment = Deployment.environments.include? environment

    application_list = "#{Deployment.applications[0..-2].join(', ')}"
    application_list << " or #{Deployment.applications.last}"
    environment_list = "#{Deployment.environments[0..-2].join(', ')}"
    environment_list << " or #{Deployment.environments.last}"

    if valid_application && valid_environment
      text = "HAL has deployed #{application} to #{environment}, hypothetically. "
      text << "I'm not actually able to give you information about whether or not "
      text << "the deploy was successful because I can't deliver messages to you "
      text << "unprompted. That would actually be a terrible feature, imagine if "
      text << "LinkedIn could send voice messages to your living room. You'd never "
      text << "stop hearing about how you're getting noticed."
    elsif valid_application && !valid_environment
      text = "I'm not sure where you think I'm able to deploy things but "
      text << "#{environment} isn't one of them. Want to try again with "
      text << "#{environment_list}? Worst case scenario you get it wrong again "
      text << "and confirm your lifelong suspicion that you completely "
      text << "lack value. At least we can agree on something."
    elsif !valid_application && valid_environment
      text = "I'm having trouble finding the application #{application}, though it's "
      text << "clear you're trying to deploy to the #{environment} environment. "
      text << "I can deploy #{application_list}. "
      text << "Do you want to try again? Alternatively you could become a monk."
    else
      text = "OK that wasn't even close. You want to deploy #{application} to "
      text << "#{environment}? Neither of those is an option. I'm pretty fancy "
      text << "but I can't read minds, especially feeble ones. I can deploy "
      text << "#{application_list} to any of the #{environment_list} environments. "
      text << "I'd encourage you to try again but you clearly have no idea what's "
      text << "going on right now. Have you been drinking?"
    end
  end
end
