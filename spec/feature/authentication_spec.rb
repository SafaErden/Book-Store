require 'rails_helper'

RSpec.feature 'Authentications', type: :feature do
  before :each do
    @author = Author.create(name: 'Author')
  end
  it 'Should Create a new author' do
    visit new_author_path
    fill_in 'author[name]', with: 'Name'

    click_button 'commit'
    expect(page).to have_content('My Books')
    expect(page).to have_content('Log Out')
  end

  it 'Should Sign in' do
    visit new_auth_path
    fill_in 'name', with: 'Author'
    click_button 'commit'
    expect(page).to have_content('My Books')
    expect(page).to have_content('Log Out')
  end

  it 'Should Log out' do
    visit new_auth_path
    fill_in 'name', with: 'Author'
    click_button 'commit'
    click_on 'Log Out'
    expect(page).to have_content('Sign In')
    expect(page).to have_content('Successfully logged out.')
  end
end
