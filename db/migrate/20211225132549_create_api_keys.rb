class CreateAPIKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :api_keys, id: :uuid do |t|
      t.string :description
      t.string :secret_digest

      t.timestamps
    end
  end
end
