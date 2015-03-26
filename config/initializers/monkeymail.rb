CatarseMonkeymail.configure do |config|
  config.api_key = ENV[:mailchimp_api_key]
  config.list_id = ENV[:mailchimp_list_id]
  config.successful_projects_list = ENV[:mailchimp_successful_projects_list]
  config.failed_projects_list = ENV[:mailchimp_failed_projects_list]
end
