class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts, id: :uuid do |t|
      t.string :name
      t.string :address

      t.timestamps
    end
    add_index :contacts, :name, unique: true
  end
end
