# Be sure to restart your server when you modify this file.

# if Rails.env.production? && ENV['BASE_DOMAIN']
#   Catarse::Application.config.session_store :cookie_store, key: ENV['SECRET_TOKEN'], domain: ENV['BASE_DOMAIN']
# else
  Catarse::Application.config.session_store :cookie_store, key: ENV['SECRET_TOKEN']
# end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Catarse::Application.config.session_store :active_record_store

