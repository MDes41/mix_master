require 'rails_helper'

RSpec.feature "User submits a new artist" do

  scenario "they see the page for the individual artist" do
    artist_name         = "Bob Marley"
    artist_image_path   = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    visit '/artists'
    click_on "New Artist"
    fill_in "artist_name", with: artist_name
    fill_in "artist_image_path", with: artist_image_path
    click_on "Create Artist"

    expect(page).to have_content artist_name
    expect(page).to have_css("img[src=\"#{artist_image_path}\"]")
  end

  context " the submitted data is invalid" do
    scenario "they see an error message when new artist is created without name" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400?MI0003/146/MI0003146038.jpg"

      visit artists_path
      click_on "New Artist"
      fill_in "artist_image_path", with: artist_image_path
      click_on "Create Artist"

      expect(page).to have_content "Name can't be blank"
    end

    scenario "They see an error message when update artist name field is not filled in" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400?MI0003/146/MI0003146038.jpg"
      artist = Artist.create(name: "Bob Marley", image_path: artist_image_path)

      visit artist_path(artist)
      click_on "Edit"
      fill_in "artist_name", with: ""
      click_on "Update Artist"
      expect(page).to have_content "Name can't be blank"
    end
  end

  context "An artist has already been created" do
    scenario "Should see a list of artist creatd after clicking the show all artists on show page" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400?MI0003/146/MI0003146038.jpg"
      artist = Artist.create(name: "Bob Marley", image_path: artist_image_path)

      visit artist_path(artist)
      click_on "<< Back to Artists"

      expect(page).to have_content "All Artists"
    end

    scenario "Should see each artist name on artists page" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400?MI0003/146/MI0003146038.jpg"
      artist = Artist.create(name: "Bob Marley", image_path: artist_image_path)
      visit artists_path

      expect(page).to have_content "Bob Marley"

      click_on "Bob Marley"

      expect(page).to have_content "Bob Marley"
      expect(page).to have_css("img[src=\"#{artist_image_path}\"]")
    end

    scenario "Should see an updated artist name and existing image" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400?MI0003/146/MI0003146038.jpg"
      artist = Artist.create(name: "Bob Marley", image_path: artist_image_path)
      visit artist_path(artist.id)
      click_on "Edit"
      fill_in "artist_name", with: "Jerry Garcia"
      click_on "Update Artist"

      expect(page).to have_content "Jerry Garcia"
      expect(page).to have_css "img[src=\"#{artist_image_path}\"]"
    end

    scenario "Should see the index without artist name after deleting" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400?MI0003/146/MI0003146038.jpg"
      artist = Artist.create(name: "Bob Marley", image_path: artist_image_path)

      visit artists_path
      expect(page).to have_content("Bob Marley")

      visit artist_path(artist)
      click_on "Delete"

      expect(page).to_not have_content("Bob Marley")
      expect(page).to have_content("All Artists")
    end
  end



end
