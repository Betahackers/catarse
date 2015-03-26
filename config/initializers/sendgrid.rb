# begin
#   if Rails.env.production?
#     ActionMailer::Base.smtp_settings = {
#       address: 'smtp.sendgrid.net',
#       port: '587',
#       authentication: :plain,
#       user_name: ENV['SENDGRID_USER_NAME'],
#       password: ENV['SENDGRID'],
#       domain: 'heroku.com'
#     }
#     ActionMailer::Base.delivery_method = :smtp
#   end
# rescue
#   nil
# end
