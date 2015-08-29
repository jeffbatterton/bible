class UpdateVerses < ActiveRecord::Migration
  def change
    rename_column :verses, :chapter, :chapter_number
    rename_column :verses, :verse, :verse_number
    rename_column :verses, :book_id, :book_number
    remove_column :verses, :book
  end
end
