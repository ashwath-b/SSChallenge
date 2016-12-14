module MailgunWebhook
  require 'openssl'

  def self.verify_authenticity(api_key, token, timestamp, signature)
    digest = OpenSSL::Digest::SHA256.new
    data = [timestamp, token].join
    signature == OpenSSL::HMAC.hexdigest(digest, api_key, data)
  end

  def self.suppressed_emails
     emails = bounce + unsubscribe + complaint
  end

  def self.get_bounces
    result = RestClient.get "https://api:YOUR_API_KEY@api.mailgun.net/v3/YOUR_DOMAIN_NAME/bounces"
  end

  def self.get_unsubscribes
    result = RestClient.get "https://api:YOUR_API_KEY@api.mailgun.net/v3/YOUR_DOMAIN_NAME/unsubscribes"
  end

  def self.get_complaints
    result = RestClient.get "https://api:YOUR_API_KEY@api.mailgun.net/v3/YOUR_DOMAIN_NAME/complaints"
  end

end
