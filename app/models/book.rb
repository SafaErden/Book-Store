class Book < ApplicationRecord
  belongs_to :author
  has_many :book_libraries
  has_many :libraries, through: :book_libraries

  validates :name, presence: true, length: { minimum: 2, message: 'should have at least 2 characters.' }
  validate :greater_than_zero

  scope :desc, -> { order('created_at DESC') }

  def greater_than_zero
    errors.add(:amount, 'should be greater than 0') if amount.to_i < 1
  end
end
