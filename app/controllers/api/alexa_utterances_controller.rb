class Api::AlexaUtterancesController < ApiController
  def create
    if valid_request?
      AlexaUtterance.create(payload: params)
      alexa_response = AlexaResponse.new(payload: params)
      render json: alexa_response, status: 200
    else
      render plain: "Invalid request", status: 400
    end
  end

  private

  def valid_request?
    params[:session][:application][:applicationId] == ENV["ALEXA_APPLICATION_ID"]
  end
end
