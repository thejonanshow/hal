class Intents::Unknown
  include Intent

  def initialize(payload:)
  end

  def output_text
    "Hal has no idea what you are talking about. He kindly requests that you stop babbling."
  end
end
