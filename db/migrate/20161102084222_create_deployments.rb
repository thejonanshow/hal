class CreateDeployments < ActiveRecord::Migration[5.0]
  def change
    create_table :deployments do |t|
      t.string :text
      t.string :status

      t.timestamps
    end
  end
end
