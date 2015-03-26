if Rails.env.production?
  ActionMailer::Base.asset_host = ENV['HOST']
  Rails.application.routes.default_url_options = {host: ENV['HOST'], protocol: 'https'} 
else
  Rails.application.routes.default_url_options = {host: 'localhost:3000'} 
end
