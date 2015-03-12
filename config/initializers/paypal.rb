PayPal::SDK.configure(
  :mode      => Rails.env.production ? "live" : "sandbox",  # Set "live" for production
  :app_id    => Rails.env.production ? "APP-5J658840LU181871W" : "APP-80W284485P519543T",
  :username  => ENV['PAYPAL_USERNAME'],
  :password  => ENV['PAYPAL_PASSWORD'],
  :signature => ENV['PAYPAL_SIGNATURE'])
