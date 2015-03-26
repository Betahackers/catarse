# Be sure to restart your server when you modify this file.

# if Rails.env.production? && ENV[:base_domain]
#   Catarse::Application.config.session_store :cookie_store, key: ENV[:secret_token], domain: ENV[:base_domain]
# else
  Catarse::Application.config.session_store :cookie_store, key: ENV[:secret_token]
# end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Catarse::Application.config.session_store :active_record_store

