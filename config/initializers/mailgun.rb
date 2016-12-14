Mailgun.configure do |config|
  config.api_key = ENV['mailgun-api-key']
  config.domain  = ENV['mailgun-domain']
end
