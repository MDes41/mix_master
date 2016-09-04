require 'rails_helper'

RSpec.feature "User submist a new song" do

  context "error messages" do
    scenario "should see an error message that title cannot be blank creating" do
      artist = create(:artist)

      visit artist_path(artist)
      click_on "New Song"
      click_on "Create Song"

      expect(page).to have_content "Title can't be blank"
    end

    scenario "should see an error message that title cannot be blank when updating" do
      artist = create(:artist)
      song = artist.songs.create(title: "One Love")

      visit song_path(song)
      click_on "Edit"
      fill_in "song_title", with: ""
      click_on "Update Song"

      expect(page).to have_content "Title can't be blank"
    end

  end

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


    scenario "Should see the updated name of the song when updating" do
      artist = create(:artist)
      song = artist.songs.create(title: "One Love")

      visit song_path(song)

      click_on "Edit"
      fill_in "song_title", with: "No Woman No Cry"
      click_on "Update Song"

      expect(page).to have_content("No Woman No Cry")
      expect(page).to have_link artist.name, href: artist_path(artist)
    end

    scenario "User should be able to view all songs of the artist" do
      artist = create(:artist)
      song_1 = artist.songs.create(title: "One Love")
      song_2 = artist.songs.create(title: "No Woman No Cry")
      song_3 = artist.songs.create(title: "A Song")

      visit artist_path(artist)
      click_on "View Songs"

      expect(page.find("li:first-child")).to have_link song_3.title, href: song_path(song_3)
      expect(page.find("li:nth-child(2)")).to have_link song_2.title, href: song_path(song_2)
      expect(page.find("li:last-child")).to have_link song_1.title, href: song_path(song_1)
    end
  end
end
