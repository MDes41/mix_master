require 'rails_helper'

RSpec.feature "User edits a playlist" do
  scenario "when a user adds a new song and delete another they should see the updated playlist" do
    playlist = create(:playlist)
    song_1 = playlist.songs.create(attributes_for(:song))
    song_2 = create(:song)

    visit playlist_path(playlist)

    expect(page).to have_content playlist.name
    expect(page).to have_link song_1.title, href: song_path(song_1)
    expect(page).to_not have_link song_2.title, href: song_path(song_2)

    click_on "Edit"
    fill_in "playlist_name", with: "New Playlist"
    uncheck("song-#{song_1.id}")
    check("song-#{song_2.id}")
    click_on "Update Playlist"

    expect(page).to have_content "New Playlist"
    expect(page).to_not have_link song_1.title, href: song_path(song_1)
    expect(page).to have_link song_2.title, href: song_path(song_2)
  end
end
