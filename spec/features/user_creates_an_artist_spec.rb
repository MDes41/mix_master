require 'rails_helper'

RSpec.feature "User submits a new artist" do
  # As a user
  # When I visit the artists index
  # And I click "new Artist"
  # And I fill in the name
  # And I fill in an image path
  # And I click "Create Artist"
  # Then I shoud see the artist name and image on the page
  scenario "they see the page for the individual artist" do
    skip
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
    scenario "they see an error message" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400?MI0003/146/MI0003146038.jpg"

      visit artist_path
      click "New Artist"
      fill_in "artist_image_path", with: artist_image_path
      click_on "Create Artist"

      expect(page).to have_content "Name can't be blank"
    end
  end

end
