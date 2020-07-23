require 'rails_helper'

RSpec.feature 'Authentications', type: :feature do
  before :each do
    @author = Author.create(name: 'Author')
    visit new_auth_path
    fill_in 'name', with: 'Author'
    click_button 'commit'
  end
  it 'Should create a new category' do
    visit new_library_path
    fill_in 'library[name]', with: 'Action'
    attach_file('library[image]', Rails.root + 'app/assets/images/rails.JPG')
    click_button 'commit'
    expect(page).to have_content('Action')
    expect(page).to have_content('Category was successfully created.')
  end

  it 'Should Publish a new book' do
    visit new_library_path
    fill_in 'library[name]', with: 'Action'
    attach_file('library[image]', Rails.root + 'app/assets/images/rails.JPG')
    click_button 'commit'

    visit new_book_path
    fill_in 'book[name]', with: 'Algorithms and Data Structure'
    fill_in 'book[amount]', with: 1

    click_button 'commit'
    expect(page).to have_content('My Books')
    expect(page).to have_content('Algorithms and Data Structure')
    expect(page).to have_content('Book was successfully created.')
  end
end
