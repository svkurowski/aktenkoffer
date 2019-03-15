# frozen_string_literal: true
# This migration comes from gutentag (originally 1)

class CreateGutentagTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :gutentag_taggings do |table|
      table.integer :tag_id, null: false
      table.uuid :taggable_id, null: false
      table.string :taggable_type, null: false
      table.timestamps null: false
    end

    add_index :gutentag_taggings, :tag_id
    add_index :gutentag_taggings, [:taggable_type, :taggable_id]
    add_index :gutentag_taggings, [:taggable_type, :taggable_id, :tag_id],
              unique: true, name: 'unique_taggings'
  end
end
