Catarse::Application.configure do
  config.i18n.load_path += Dir[Rails.root.join('lib', 'fundoo', 'locales','**', '*.{rb,yml}').to_s] 
  config.i18n.default_locale = :en
  config.time_zone = 'Madrid'
  config.filter_parameters << :iban
end
