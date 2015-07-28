class RemoveStampToArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :stamp
  end
end
