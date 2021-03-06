CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      provider: 'AWS',
      # host: 's3.amazonaws.com',
      # endpoint: 'http://s3.amazonaws.com',
      region: 'eu-west-1',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'] || 'AWS_ACCESS_KEY_ID' ,
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || 'AWS_SECRET_ACCESS_KEY'
    }
    config.fog_directory  = ENV['AWS_BUCKET'] || 'AWS_BUCKET'
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  else
    config.enable_processing = false if Rails.env.test? or Rails.env.cucumber?
  end
end

module CarrierWave
  module RMagick

    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage } unless img.quality == percentage
        img = yield(img) if block_given?
        img
      end
    end

  end
end


