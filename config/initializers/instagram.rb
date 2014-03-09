require "instagram"

Instagram.configure do |config|
  config.client_id = '81becf58c5ca4d06bfcfa366fa652228'
  config.client_secret = '6a06465bd1d04416816e976402eb8230'
end

# CALLBACK_URL = "http://localhost:3000/session/callback"
CALLBACK_URL = "http://localhost:3000/session/callback"