class AddBookIdToVerses < ActiveRecord::Migration
  def change
    add_column :verses, :book_id, :integer
  end
end
