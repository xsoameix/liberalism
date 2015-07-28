class CreateLibertarians < ActiveRecord::Migration
  def change
    create_table :libertarians do |t|
      t.integer :author_id

      t.timestamps null: false
    end

    add_index :libertarians, :author_id
  end
end
