class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :subtitle
      t.string :author
      t.date   :begin_date
      t.date   :end_date
      t.string :stamp
      t.text   :body
      t.string :tag

      t.timestamps null: false
    end
  end
end
