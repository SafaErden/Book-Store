class Book < ApplicationRecord
  belongs_to :author
  has_many :book_libraries
  has_many :libraries, through: :book_libraries
  
  validate :name_length
  validate :greater_than_zero

  scope :desc, -> { order('created_at DESC') }

  def greater_than_zero
    if amount.to_i < 1
      errors.add(:amount, "should be greater than 0")
    end
  end

  def name_length
    if name.size < 2
      errors.add(:name, "should contain at least two characters")
    end
  end
end
