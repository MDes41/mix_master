
FactoryGirl.define do

  # post factory with a `belongs_to` association for the user
  factory :artist do
    name
    image_path "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"
  end

  sequence :name do |n|
    "Artist #{n.to_s}"
  end

  sequence :title, ["A", "C", "B"].cycle do |n|
    "#{n} Title"
  end


  factory :playlist do
    sequence :name do |n|
      "Playlist #{n}"
    end

    factory :playlist_with_songs do
      songs { create_list(:song, 3)}
    end
  end

  factory :song do
    title
    artist
  end

end
