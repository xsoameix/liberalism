class CreateNewspapers < ActiveRecord::Migration
  def change
    create_table :newspapers do |t|
      t.integer :author_id

      t.timestamps null: false
    end

    add_index :newspapers, :author_id
  end
end
