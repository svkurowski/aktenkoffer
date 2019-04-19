# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |table|
      ## Database authenticatable
      table.string :username, null: false, default: ''
      table.string :encrypted_password, null: false, default: ''

      ## Rememberable
      table.datetime :remember_created_at

      table.timestamps null: false
    end

    add_index :users, :username, unique: true
  end
end
