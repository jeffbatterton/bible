class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.integer  :book_number
      t.integer  :chapter_number

      t.timestamps
    end
  end
end
