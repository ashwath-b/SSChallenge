module MailgunWebhook
  require 'openssl'

  def self.verify_authenticity(api_key, token, timestamp, signature)
    digest = OpenSSL::Digest::SHA256.new
    data = [timestamp, token].join
    signature == OpenSSL::HMAC.hexdigest(digest, api_key, data)
  end

  def self.suppressed_emails
     emails = get_bounces + get_unsubscribes + get_complaints
  end

  def self.get_bounces
    # mg_client = Mailgun::Client.new("your-api-key")
    # mg_events = Mailgun::Events.new(mg_client, "your-domain")
    # result = mg_events.get({'limit' => 25, 'event' => 'bounces'})
    from = "https://api:#{ENV['mailgun-api-key']}@api.mailgun.net/v3/#{ENV['mailgun-domain']}/bounces"
    email = extract_email_list(from)
  end

  def self.get_unsubscribes
    from = "https://api:#{ENV['mailgun-api-key']}@api.mailgun.net/v3/#{ENV['mailgun-domain']}/unsubscribes"
    email = extract_email_list(result)
  end

  def self.get_complaints
    from = "https://api:#{ENV['mailgun-api-key']}@api.mailgun.net/v3/#{ENV['mailgun-domain']}/complaints"
    email = extract_email_list(result)
  end

  def self.is_valid_email(email)
    url_params[:address] = email
    query_string = url_params.collect {|k, v| "#{k.to_s}=#{CGI::escape(v.to_s)}"}.join("&")
    result = RestClient.get "https://api:#{ENV['mailgun-pub-key']}@api.mailgun.net/v3/address/validate?#{query_string}"
    result["is_valid"] == true
  end

  def self.extract_email_list(from)
    email = []
    result = RestClient.get from
    loop do
      email << result["items"][0]["address"]
      break if result["paging"]["next"] == nil
    end
    email
  end

end
