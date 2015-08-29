class ChangeBookDataType < ActiveRecord::Migration
  def up
    change_column :verses, :book, :string
  end

  def down
    change_column :verses, :book, :integer
  end
end
