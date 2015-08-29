class Verse < ActiveRecord::Base
  # translation (string)
  # book_number (integer)
  # chapter_number (integer)
  # verse_number (integer)
  # body (text)

  belongs_to :chapter
end
