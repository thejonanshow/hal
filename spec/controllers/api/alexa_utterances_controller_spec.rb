require 'rails_helper'

RSpec.describe Api::AlexaUtterancesController, type: :controller do
  context "#create" do
    let(:data) { Fixture.load("utterance") }

    it "creates an alexa utterance with the payload" do
      expect { post :create, params: data }.to change {
        AlexaUtterance.count
      }.from(0).to(1)
    end

    it "returns 400 if the application ID can't be verified" do
      data["session"]["application"]["applicationId"] = "wrong"
      post :create, params: data
      expect(response.status).to eql(400)
    end

    it "returns appropriate output speech" do
      post :create, params: data
      response_body = JSON.parse(response.body)

      output = response_body["response"]["outputSpeech"]["text"]
      expect(output).to include("test-application to test-environment")
    end
  end
end
