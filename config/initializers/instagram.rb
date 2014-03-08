require "instagram"

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_CLIENT_ID_BEAM']
  config.client_secret = ENV['INSTAGRAM_CLIENT_SECRET_BEAM']
end

# CALLBACK_URL = "http://localhost:3000/session/callback"
CALLBACK_URL = "http://beam-team.herokuapp.com/session/callback"