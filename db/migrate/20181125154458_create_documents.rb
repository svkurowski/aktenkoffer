class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents, id: :uuid do |t|
      t.string :title
      t.references :sender, type: :uuid, foreign_key: { to_table: :contacts }
      t.references :recipient, type: :uuid, foreign_key: { to_table: :contacts }
      t.date :sent_at
      t.date :received_at

      t.timestamps
    end
  end
end
