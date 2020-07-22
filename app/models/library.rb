class Library < ApplicationRecord
  belongs_to :author
  has_many :book_libraries
  has_many :books, through: :book_libraries
  has_one_attached :image

  validates :name, presence: true, length: { minimum: 2, message: 'should have at least 2 characters.' }
  validate :logo_validation

  def logo_validation
    if image.attached?
      if image.blob.byte_size > 1_000_000
        image.purge
        errors[:base] << 'Too big'
      elsif !image.blob.content_type.starts_with?('image/')
        image.purge
        errors[:base] << 'Wrong format'
      end
    elsif !image.attached?
      errors.add(:image, 'should be added')
    end
  end

  scope :asc, -> { order('name ASC') }
end
