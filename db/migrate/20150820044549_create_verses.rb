class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.string  :translation
      t.integer :book, :limit => 3
      t.integer :chapter, :limit => 3
      t.integer :verse, :limit => 3
      t.text    :body

      t.timestamps
    end
  end
end
