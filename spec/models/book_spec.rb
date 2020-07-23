# rubocop:disable Lint/UselessAssignment
require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is not valid without a name' do
    book = Book.new(name: nil)
    expect(book).to_not be_valid
  end
  it 'is not valid without a name of minimum length 2 characters' do
    book = Book.new(name: 'A')
    expect(book).to_not be_valid
  end
  it 'is not valid to create another author with the same name' do
    book = Book.create(name: 'Author')
    book_new = Book.new(name: 'Author')
    expect(book_new).to_not be_valid
  end
  describe 'associations' do
    it { should belong_to(:author) }
    it { should have_many(:book_libraries) }
    it { should have_many(:libraries).through(:book_libraries) }
  end
end
# rubocop:enable Lint/UselessAssignment
