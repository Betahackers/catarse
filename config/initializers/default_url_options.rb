if Rails.env.production?
  ActionMailer::Base.asset_host = ENV[:host]
  Rails.application.routes.default_url_options = {host: ENV[:host], protocol: 'https'} 
else
  Rails.application.routes.default_url_options = {host: 'localhost:3000'} 
end
