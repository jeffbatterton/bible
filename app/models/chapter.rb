class Chapter < ActiveRecord::Base
  # book_nunber (integer)
  # chapter_number (integer)

  belongs_to :book
  has_many :verses

end
