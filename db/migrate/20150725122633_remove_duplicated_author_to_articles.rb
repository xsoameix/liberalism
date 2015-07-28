class RemoveDuplicatedAuthorToArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :author
  end
end
