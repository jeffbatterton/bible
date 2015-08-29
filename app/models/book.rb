class Book < ActiveRecord::Base
  # title

  has_many :chapters
end
