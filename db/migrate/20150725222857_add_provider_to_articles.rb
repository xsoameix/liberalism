class AddProviderToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :provider_id, :integer
    add_index :articles, :provider_id
  end
end
