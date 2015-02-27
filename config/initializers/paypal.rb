PayPal::SDK.configure(
  :mode      => "sandbox",  # Set "live" for production
  :app_id    => "APP-80W284485P519543T",
  :username  => ENV['PAYPAL_USERNAME'],
  :password  => ENV['PAYPAL_PASSWORD'],
  :signature => ENV['PAYPAL_SIGNATURE'])
