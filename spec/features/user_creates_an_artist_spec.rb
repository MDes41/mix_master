require 'rails_helper'

RSpec.feature "User submits a new artist" do

  # When I visit the artists index
  # And I click "new Artist"
  # And I fill in the name
  # And I fill in an image path
  # And I click "Create Artist"
  # Then I shoud see the artist name and image on the page
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

  # As a user
  # When I visit the artists index
  # And I click "New artist"
  # And I fill in an image path
  # And I click "Create Artist"
  # Thne I shoud see "Name cannot be blank" on the page
  context " the submitted data is invalid" do
    scenario "they see an error message when new artist is created without name" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400?MI0003/146/MI0003146038.jpg"

      visit artists_path
      click_on "New Artist"
      fill_in "artist_image_path", with: artist_image_path
      click_on "Create Artist"

      expect(page).to have_content "Name can't be blank"
    end
    # As a user
    # Whne I visit the artist show page
    # And I click on the "Edit Artist"
    # And I delete the information for the name
    # And I click Update Artist
    # Then I should see "Name cannot be blank" on the page
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
    # As a user
    # Given that artists exist in the database
    # When I visit the artists index
    # Then I should see each artist's name
    # And each name should link to that artist's individual page
    scenario "Should see each artist name on artists page" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400?MI0003/146/MI0003146038.jpg"
      artist = Artist.create(name: "Bob Marley", image_path: artist_image_path)
      visit artists_path

      expect(page).to have_content "Bob Marley"

      click_on "Bob Marley"

      expect(page).to have_content "Artist: Bob Marley"
      expect(page).to have_css("img[src=\"#{artist_image_path}\"]")
    end

    # As a user
    # Given that an artist exists in the database
    # When i visit that artist's show page
    # And I click on "Edit"
    # And I fill in a new name
    # And I click on "Update Artist"
    # Then I should see the artist's updated name
    # Then I should see the existing image
    scenario "Should see an updated artist name and existing image" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400?MI0003/146/MI0003146038.jpg"
      artist = Artist.create(name: "Bob Marley", image_path: artist_image_path)
      visit artist_path(artist.id)
      click_on "Edit"
      fill_in "artist_name", with: "Jerry Garcia"
      click_on "Update Artist"

      expect(page).to have_content "Artist: Jerry Garcia"
      expect(page).to have_css "img[src=\"#{artist_image_path}\"]"
    end
    # As a user
    # Given that an artist exists in the database
    # When I visit that artist's show page
    # And I click on "Delete"
    # Then I should be back on the artist index page
    # Then I should not see the artist's name
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
