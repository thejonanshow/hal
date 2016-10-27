require 'rails_helper'

RSpec.describe Api::AlexaUtterancesController, type: :controller do
  context "#create" do
    let(:data) {
      {
        test: "foo",
        session: {
          application: {
            applicationId: "test-alexa-application-id"
          }
        }
      }
    }
    it "creates an alexa utterance with the payload" do
      expect { post :create, params: data }.to change {
        AlexaUtterance.count
      }.from(0).to(1)
    end

    it "returns 400 if the application ID can't be verified" do
      data[:session][:application][:applicationId] = "wrong"
      post :create, params: data
      expect(response.status).to eql(400)
    end
  end
end
