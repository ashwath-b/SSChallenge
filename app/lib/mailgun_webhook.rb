module MailgunWebhook
  require 'openssl'

  def self.verify_authenticity(api_key, token, timestamp, signature)
    digest = OpenSSL::Digest::SHA256.new
    data = [timestamp, token].join
    signature == OpenSSL::HMAC.hexdigest(digest, api_key, data)
  end

  def self.suppressed_emails
    # We could even query user table where valid_email is false
    # emails = User.where(:valid_email => false).pluck(:email)
     emails = get_bounces + get_unsubscribes + get_complaints
  end

  def self.get_bounces
    emails = extract_email_list("bounces")
  end

  def self.get_unsubscribes
    emails = extract_email_list("unsubscribes")
  end

  def self.get_complaints
    emails = extract_email_list("complaints")
  end

  def self.is_valid_email(email)
    url_params[:address] = email
    query_string = url_params.collect {|k, v| "#{k.to_s}=#{CGI::escape(v.to_s)}"}.join("&")
    result = RestClient.get "https://api:#{ENV['mailgun-pub-key']}@api.mailgun.net/v3/address/validate?#{query_string}"
    result["is_valid"] == true
  end

  def self.extract_email_list(type)
    emails = []
    result = RestClient.get "https://api:#{ENV['mailgun-api-key']}@api.mailgun.net/v3/#{ENV['mailgun-domain']}/#{type}"
    loop do
      emails << result["items"][0]["address"]
      break if result["paging"]["next"] == nil
    end
    emails
  end

end
