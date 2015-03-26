CatarseMonkeymail.configure do |config|
  config.api_key = ENV['MAILCHIMP_API_KEY']
  config.list_id = ENV['MAILCHIMP_LIST_ID']
  config.successful_projects_list = ENV['MAILCHIMP_SUCCESSFUL_PROJECTS_LIST']
  config.failed_projects_list = ENV['MAILCHIMP_FAILED_PROJECTS_LIST']
end
