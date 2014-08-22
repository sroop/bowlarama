require 'rails_helper'

feature 'User manages games', %q{
  So that I can manage games
  As a user
  I want to create, update and delete them
} do

  let!(:user) { create(:user) }

  before do 
    login_as user
    visit '/'
  end

  scenario 'No games' do
    expect(page).to have_content("Bowlerama!")
  end

  scenario 'User creates a game' do
    click_on 'Create game'
    fill_in 'Title', with: 'Awesome Game'
    select('4', :from => 'Players')
    click_on 'Create game'
    expect(page).to have_content('Awesome Game')
  end

end