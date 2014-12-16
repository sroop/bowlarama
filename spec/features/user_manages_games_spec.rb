require 'rails_helper'

feature "User manages games" do

  let!(:sroop) { create(:user, username: "sr00p") }
  let!(:drew) { create(:user, username: "drusk0") }
  let!(:rain) { create(:user, username: "r00ni") }
  let!(:game) { create(:game) }

  before do
    login_as sroop
    visit root_path
  end

  scenario 'Creating a game' do
    click_on 'Create game'
    fill_in 'Title', with: 'Awesome Game'
    select 'drusk0'
    click_on 'Create game'
    expect(page).to have_content("Saved successfully")
    expect(page).to have_content('Awesome Game')
    expect(page).to have_content('drusk0')
    expect(page).to have_content('sr00p')
  end

  context 'Editing and updating a game' do

    before do
      click_on 'Create game'
      fill_in 'Title', with: 'Awesome Game'
      select 'drusk0'
      click_on 'Create game'
    end

    scenario 'Adding more players' do
      expect(page).to have_content("Saved successfully")
      click_on 'Add more players'
      select 'r00ni'
      click_on 'Update'
      expect(page).to have_content("Saved successfully")
      expect(page).to have_content('drusk0')
      expect(page).to have_content('r00ni')
      expect(page).to have_content('sr00p')
    end

    scenario "Editing the title" do
      click_on 'Edit title'
      fill_in 'Title', with: 'Bowling Amigos'
      click_on 'Update'
      expect(page).to have_content("Saved successfully")
      expect(page).to have_content('Bowling Amigos')
      expect(page).not_to have_content('Awesome Game')
    end

  end

  scenario 'Deleting a game' do
    expect(page).to have_content("Tekken Bowl")
    click_on 'Delete'
    expect(page).not_to have_content("Tekken Bowl")
    expect(page).to have_content("Deleted!")
  end

end