require "rails_helper"

RSpec.feature "User creates a playlist" do
  scenario "they see the page for the indivicual playlist" do
    artist_1 = create(:artist)
    song_one, song_two, song_three = create_list(:song, 3, :artist_id => artist_1.id)

    playlist_name = "My Jams"

    visit playlists_path
    click_on "New Playlist"
    fill_in "playlist_name", with: playlist_name
    check("song-#{song_one.id}")
    check("song-#{song_three.id}")
    click_on "Create Playlist"

    expect(page).to have_content playlist_name

    within("li:first") do
      expect(page).to have_link song_one.title, href: song_path(song_one)
    end

    within("li:last") do
      expect(page).to have_link song_three.title, href: song_path(song_three)
    end

  end
end
