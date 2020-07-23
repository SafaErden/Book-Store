require 'rails_helper'

RSpec.describe Library, type: :model do
  describe 'associations' do
    it { should belong_to(:author) }
    it { should have_many(:book_libraries) }
    it { should have_many(:books).through(:book_libraries) }
  end
end
