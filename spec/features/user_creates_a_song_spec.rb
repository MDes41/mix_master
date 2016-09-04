require 'rails_helper'

RSpec.feature "User submist a new song" do

  context "An artist already exists" do
    scenario "Should see a link to the song artist's individual page" do
      artist = create(:artist)

      song_title = "One Love"

      visit artist_path(artist)
      click_on "New Song"
      fill_in "song_title", with: song_title
      click_on "Create Song"

      expect(page).to have_content song_title
      expect(page).to have_link artist.name, href: artist_path(artist)
    end
  end
end
