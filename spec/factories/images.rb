# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    album
    instagram_id "8937918735_123525"
    ig_url "http://blah.com/stuff.png"
    ig_caption "#kajsdkajslh #kjahdsakjlhds #dog ajksdhljhasdgkjahslkjhg"
    ig_user "beam_tag_team"
    ig_user_avatar "http://blah.com/avatar.png"
    ig_video_url ""
    ig_created_time "1234156"
  end
end
