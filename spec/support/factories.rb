
FactoryGirl.define do

  # post factory with a `belongs_to` association for the user
  factory :artist do
    name
    image_path "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    # trait :with_songs do
    #   after :create do |song|
    #     create_list :song, 3, :artist => song
    #   end
    # end
  end

  sequence :name do |n|
    "Artist #{n.to_s}"
  end

  sequence(:title) { |n| "Song #{n.to_s}"}

  factory :song do
    title
  end

end
