require 'rails_helper'

feature "Game manages scoresheets" do

  let!(:sroop) { create(:user, username: "sr00p") }
  let!(:drew) { create(:user, username: "drusk0") }
  let!(:rain) { create(:user, username: "r00ni") }

  before do
    login_as sroop
    visit root_path
    click_on 'Create game'
    fill_in 'Title', with: 'Awesome Game'
    select 'drusk0'
    click_on 'Create game'
  end

  scenario 'A scoresheet is generated for each player in a game' do
    expect(page).to have_content('Awesome Game')
    expect(page).to have_content('drusk0')
    expect(page).to have_content('sr00p')
    scoresheets = all('.scoresheet')
    expect(scoresheets.count).to eq(2)
  end

  scenario 'After a player completes a turn, the total score is recalculated' do
    fill_in '1_1', with: 2
    fill_in '1_2', with: 4
    click_on 'Score'
    expect(page).to have_content(6)
    fill_in '2_1', with: 5
    click_on 'Score'
    expect(page).to have_content('You must complete your turn!')
    fill_in '2_2', with: 1
    click_on 'Score'
    expect(page).not_to have_content(6)
    expect(page).to have_content(12)
  end

end