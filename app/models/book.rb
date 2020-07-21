class Book < ApplicationRecord
  belongs_to :author
  has_many :book_libraries
  has_many :libraries, through: :book_libraries

  validate :name_length
  validate :greater_than_zero

  scope :desc, -> { order('created_at DESC') }

  def greater_than_zero
    errors.add(:amount, 'should be greater than 0') if amount.to_i < 1
  end

  def name_length
    errors.add(:name, 'should contain at least two characters') if name.size < 2
  end
end
