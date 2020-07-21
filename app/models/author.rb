class Author < ApplicationRecord
  validates_uniqueness_of :name
  validates :name, presence: true, length: { minimum: 2, message: 'should have at least 2 characters.' }

  has_many :libraries, foreign_key: :author_id
  has_many :books, foreign_key: :author_id

  validates :name, uniqueness: true
  validate :name_length

  def name_length
    errors.add(:name, 'should contain at least two characters') if name.size < 2
  end
end
