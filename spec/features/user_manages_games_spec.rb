require 'rails_helper'

feature "Games" do

  let!(:sroop) { create(:user, username: "sr00p") }
  let!(:drew) { create(:user, username: "drusk0") }
  let!(:rain) { create(:user, username: "r00ni") }

  before do
    login_as sroop
    visit root_path
  end

  scenario 'Creating a game' do
    click_on 'Create game'
    fill_in 'Title', with: 'Awesome Game'
    select 'drusk0'
    click_on 'Create game'
    expect(page).to have_content('Awesome Game')
    click_on 'Awesome Game'
    expect(page).to have_content('drusk0')
  end

  scenario 'Editing and updating a game' do
    click_on 'Create game'
    fill_in 'Title', with: 'Awesome Game'
    select 'drusk0'
    click_on 'Create game'
    #expect(page).to have_content("Success")
    click_on 'Awesome Game'
    click_on 'Add more players'
    select 'r00ni'
    click_on 'Update'
    expect(page).to have_content('r00ni')
    expect(page).to have_content('drusk0')
  end

end