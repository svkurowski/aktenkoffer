class AddContentToDocument < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :content, :text
  end
end
