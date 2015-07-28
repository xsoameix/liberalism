class RenameAuthorToArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :author_id, :origin_id
  end
end
