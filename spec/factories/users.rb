# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "beam_tag_team"
    avatar "http://www.instagram.com/beam.jpg"
    email "beam.tag.team@gmail.com"
  end
end
