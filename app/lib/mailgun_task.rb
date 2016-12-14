module MailgunTask

  def self.activation_email(id)
    UserMailer.registration_confirmation(id).deliver
  end

  def self.activation_reminder
    @users = User.where(created_at: DateTime.now-3.days..DateTime.now-2.days)
    @users.each do |user|
      UserMailer.activation_reminder(id).deliver unless on_suppression_list?(user.email)
    end
  end

  def self.email_history
    from = "https://api:#{ENV['mailgun-api-key']}@api.mailgun.net/v3/#{ENV['mailgun-domain']}/delivered"
    sent_emails = MailgunWebhook.extract_email_list(from)
  end

  def self.on_suppression_list?(email)
    suppressed_email_list = MailgunWebhook.suppressed_emails
    suppressed_emails.include?(email)
  end
end
