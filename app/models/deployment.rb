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

    if matched = valid?(text)
      deploy_word, application, joiner_word, environment = matched.to_a[1..-1]
      DeploymentJob.perform_later(application, environment)

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
end
