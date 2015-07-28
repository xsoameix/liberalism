class ChangeTagToArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :tag, :tag_id
    change_column :articles, :tag_id, 'integer USING CAST(tag_id AS integer)'
    add_index :articles, :tag_id
  end
end
