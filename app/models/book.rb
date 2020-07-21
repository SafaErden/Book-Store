class Book < ApplicationRecord
  belongs_to :author
  has_many :book_libraries
  has_many :libraries, through: :book_libraries

  scope :desc, -> { order("created_at DESC") }

end
