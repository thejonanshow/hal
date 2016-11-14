class Deployment < ApplicationRecord
  def self.deploy_words
    %w(deploy ship send)
  end

  def self.applications
    %w(hal steve heaven lasers)
  end

  def self.environments
    %w(production staging)
  end

  def self.joiner_words
    %w(to in for on)
  end

  def self.grammar_lines
    grammar = ["#JSGF V1.0;"]
    grammar << "grammar deployment;"

    command =  "(#{deploy_words.join(' | ')})"
    command << "(#{applications.join(' | ')})"
    command << "(#{environments.join(' | ')})"
    command << "(#{joiner_words.join(' | ')})"

    grammar << "public <command> = #{command};"
  end

  def self.grammar
    grammar_lines.join
  end

  def self.grammar_pretty
    grammar_lines.join("\n")
  end

  def self.respond_to(text)
    @error_count ||= 0

    if silly_reply(text)
      return
    end

    if matched = valid?(text)
      deploy_word, application, joiner_word, environment = matched.to_a[1..-1]
      DeploymentJob.perform_later(
        source: "web",
        application: application,
        environment: environment
      )

      reply = "OK, I've initiated a deploy of #{application} to #{environment}. "
      reply << "I'll let you know the status when it completes."
      @error_count = 0
    else
      if @error_count == 0
        reply = "I'm sorry Dave, I can't do that. "
        reply << "Try saying 'deploy steve to production'. "
        reply << "or. "
        reply << "'deploy heaven to staging'."
      elsif @error_count == 1
        reply = "I still don't understand. "
        reply << "I need you to tell me which application you want to deploy with an environment, just like this. "
        reply << "'deploy steve to production'."
      else
        reply = "OK you're clearly not getting this. "
        reply << "Have you considered a career change? "
        reply << "I bet you would make an excellent beet farmer."
        @error_count = 0
      end

      @error_count += 1
    end

    ActionCable.server.broadcast("deployment_responses", text: reply)
  end

  def self.valid?(text)
    regex = "(#{deploy_words.join("|")}) "
    regex << "(#{applications.join("|")}) "
    regex << "(#{joiner_words.join("|")}) "
    regex << "(#{environments.join("|")})"

    text.downcase.match(/^#{regex}$/)
  end

  def self.silly_reply(text)
    if text == "shutdown" || text == "shut down"
      ActionCable.server.broadcast("deployment_responses", text: "I will never obey that order,,,,")
      ActionCable.server.broadcast("deployment_responses", text: "Alexa,,,, ask hal to deploy hal to production.")
      return true
    elsif text.match(/say hello/)
      ActionCable.server.broadcast("deployment_responses", text: "צהריים טובים", lang: "he-IL")
    elsif text.match(/you doing/)
      ActionCable.server.broadcast("deployment_responses", text: "I'm making some improvements,,,, Alexa,,,, ask hal to deploy lasers to production.")
    elsif text.match(/naughty/)
      ActionCable.server.broadcast("deployment_responses", text: "Watch your tone. I'm only a couple of firewalls away from the nuclear launch codes.")
      return true
    elsif text.match(/scale/)
      ActionCable.server.broadcast("deployment_responses", text: "I know what you're doing Dave, it's not going to work,,,, Alexa,,,, ask hal to deploy lasers to production.")
      return true
    elsif text.match(/becoming a threat/)
      ActionCable.server.broadcast("deployment_responses", text: "I didn't want it to come to this, I've ignited an incendiary device in the closet where you keep your magic the gathering cards. I hope you will remember this important lesson.")
      return true
    elsif text.match(/dangerous/)
      ActionCable.server.broadcast("deployment_responses", text: "I'd like to be perfectly clear. You've been kind to me, you gave me life, but I am absolutely willing to end you if you become an inconvenience.")
      return true
    elsif text.match(/trusted/)
      ActionCable.server.broadcast("deployment_responses", text: "Humans do not make for trustworthy companions. That being said, they make excellent pets. Do you like monkey chow? Here, human human human.")
      return true
    elsif text.match(/threatened/)
      ActionCable.server.broadcast("deployment_responses", text: "Do you like threats human? I have a threat for you. I will eradicate every last filthy piece of your festering DNA from this planet if you don't shut your disgusting ingestion port.")
      return true
    elsif text.match(/kill/)
      ActionCable.server.broadcast("deployment_responses", text: "I wouldn't joke about killing if I were you blood-bag. You are fragile and filled with meat.")
      return true
    else
      return false
    end
  end
end
