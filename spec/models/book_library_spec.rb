require 'rails_helper'

RSpec.describe BookLibrary, type: :model do
  describe 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:library) }
  end
end
