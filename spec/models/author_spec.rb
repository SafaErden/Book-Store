# rubocop:disable Lint/UselessAssignment
require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'is not valid without a name' do
    author = Author.new(name: nil)
    expect(author).to_not be_valid
  end
  it 'is not valid without a name of minimum length 2 characters' do
    author = Author.new(name: 'A')
    expect(author).to_not be_valid
  end
  it 'is not valid to create another author with the same name' do
    author = Author.create(name: 'Author')
    author_new = Author.new(name: 'Author')
    expect(author_new).to_not be_valid
  end
  describe 'associations' do
    it { should have_many(:libraries).with_foreign_key(:author_id) }
    it { should have_many(:books).with_foreign_key(:author_id) }
  end
end
# rubocop:enable Lint/UselessAssignment
