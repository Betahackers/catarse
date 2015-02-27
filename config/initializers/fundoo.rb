require "#{Rails.root}/lib/fundoo/extensions/project_ext"

Catarse::Application.configure do
  config.i18n.load_path += Dir[Rails.root.join('lib', 'fundoo', 'locales','**', '*.{rb,yml}').to_s] 
  config.i18n.default_locale = :en
  config.time_zone = 'Madrid'
end
