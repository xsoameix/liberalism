class AddAuthorToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :author_id, :integer
    add_index :articles, :author_id
  end
end
