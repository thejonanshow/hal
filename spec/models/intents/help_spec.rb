require "rails_helper"

RSpec.describe Intents::Help do
  context "#as_json" do
    it "includes steve example" do
      help_intent = Fixture.load("utterance")
      help_intent["request"]["intent"]["name"] = "AMAZON.HelpIntent"

      result = Intents::Help.new(payload: help_intent).to_json
      expect(result).to include("deploy steve to production")
    end
  end
end
