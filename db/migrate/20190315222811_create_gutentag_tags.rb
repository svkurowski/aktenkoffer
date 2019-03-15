# frozen_string_literal: true
# This migration comes from gutentag (originally 1)

class CreateGutentagTags < ActiveRecord::Migration[5.2]
  def change
    create_table :gutentag_tags do |table|
      table.string :name, null: false
      table.timestamps null: false
      table.integer :taggings_count, default: 0, null: false
    end

    add_index :gutentag_tags, :name, unique: true
    add_index :gutentag_tags, :taggings_count
  end
end
