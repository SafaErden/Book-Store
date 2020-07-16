class Library < ApplicationRecord
  belongs_to :author
  has_many :book_libraries
  has_many :books, through: :book_libraries
  has_one_attached :image
end
