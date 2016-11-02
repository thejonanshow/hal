require "platform-api"

module Clients
  APPLICATIONS = {
    steve: {
      production: "hal-steve-production",
      staging: "hal-steve-staging"
    }
  }

  class Heroku
    attr_reader :client

    def initialize
      @client = PlatformAPI.connect(ENV["HEROKU_API_TOKEN"])
    end

    def self.deploy(application:, environment:)
      self.new.deploy(
        application: application,
        environment: environment
      )
    end

    def deploy(application:, environment:)
      slug = Excon.get("https://api.github.com/repos/thejonanshow/#{application}/tarball").headers[:location]
      Rails.logger.info "Retrieved slug: #{slug}"

      application_name = APPLICATIONS[application.downcase.to_sym][environment.downcase.to_sym]
      Rails.logger.info "Deploying #{application_name}"

      data = {
        source_blob: { url: slug }
      }

      Rails.logger.info "Posting data to Heroku: #{data}"

      client.build.create(application_name, data)

      while(client.build.list(application_name).last["status"] == "pending") do
        Rails.logger.info "Status is still pending..."
        sleep 3
      end

      client.build.list(application_name).last["status"]
    end
  end
end
