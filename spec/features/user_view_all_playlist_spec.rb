require 'rails_helper'

RSpec.feature "User view all playlists" do
  scenario "the should see each playlist name and link to that individual playlist" do
     playlist_1 = create(:playlist_with_songs, name: "BBB")
     playlist_2 = create(:playlist_with_songs, name: "AAA")

     visit playlists_path

     within("li:first") do
       expect(page).to have_link playlist_2.name, href: playlist_path(playlist_2)
     end

     within("li:last") do
       expect(page).to have_link playlist_1.name, href: playlist_path(playlist_1)
     end

  end
end
