class RecreateArticles < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string  :name, null: false, unique: true

      t.timestamps null: false
    end
    create_table :newspapers do |t|
      t.string  :name, null: false, unique: true

      t.timestamps null: false
    end
    create_table :libertarians do |t|
      t.string  :name, null: false, unique: true

      t.timestamps null: false
    end

    create_table :articles do |t|
      t.string  :title,      null: false
      t.string  :subtitle
      t.date    :begin_date, null: false
      t.date    :end_date,   null: false
      t.text    :body
      t.integer :tag_id,         null: false
      t.integer :newspaper_id,   null: false
      t.integer :libertarian_id, null: false

      t.timestamps null: false
    end
    add_index :articles, :tag_id
    add_index :articles, :newspaper_id
    add_index :articles, :libertarian_id

    create_table :reports do |t|
      t.string  :title,      null: false
      t.string  :subtitle
      t.date    :begin_date, null: false
      t.date    :end_date,   null: false
      t.text    :body
      t.integer :tag_id,         null: false
      t.integer :newspaper_id,   null: false
      t.integer :libertarian_id, null: false

      t.timestamps null: false
    end
    add_index :reports, :tag_id
    add_index :reports, :newspaper_id
    add_index :reports, :libertarian_id

    create_table :events do |t|
      t.string  :title,      null: false
      t.date    :begin_date, null: false
      t.date    :end_date,   null: false
      t.text    :body
      t.integer :tag_id,         null: false
      t.integer :libertarian_id, null: false

      t.timestamps null: false
    end
    add_index :events, :tag_id
    add_index :events, :libertarian_id

    create_table :writings do |t|
      t.date    :begin_date, null: false
      t.date    :end_date,   null: false
      t.integer :tag_id,         null: false
      t.integer :libertarian_id, null: false

      t.timestamps null: false
    end
    add_index :writings, :tag_id
    add_index :writings, :libertarian_id

    create_table :writing_entries do |t|
      t.string  :title,  null: false
      t.string  :vendor
      t.string  :author
      t.integer :writing_id, null: false

      t.timestamps null: false
    end
    add_index :writing_entries, :writing_id
  end
end
