require 'rails_helper'

RSpec.feature "User can delete a playlist" do
  scenario "User should be able to delete a playlist from the playlists index page" do
    playlist = create(:playlist_with_songs)
    visit playlists_path
    click_on "Delete"

    expect(page).to have_content "All Playlists"
  end
end
