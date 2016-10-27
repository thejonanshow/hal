class CreateAlexaUtterances < ActiveRecord::Migration[5.0]
  def change
    create_table :alexa_utterances do |t|
      t.jsonb :payload

      t.timestamps
    end
  end
end
