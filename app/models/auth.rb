class Auth < ApplicationRecord
  validates_uniqueness_of :name
  validates :name, presence: true, length: { minimum: 2, message: 'should have at least 2 characters.' }
end
