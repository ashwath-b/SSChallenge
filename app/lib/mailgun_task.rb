module MailgunTask

  def self.activation_email(id)
    UserMailer.registration_confirmation(id).deliver
  end

  def self.activation_reminder
    suppressed_email_list = MailgunWebhook.suppressed_emails
    # suppressed_email_list = User.where(:valid_email => false).pluck(:email)
    @users = User.where(created_at: DateTime.now-3.days..DateTime.now-2.days)
    @users.each do |user|
      UserMailer.activation_reminder(id).deliver unless suppressed_email_list.include?(user.email)
    end
  end

  def self.email_history
    sent_emails = MailgunWebhook.extract_email_list("delivered")
  end

  def self.on_suppression_list?(email)
    suppressed_email_list = MailgunWebhook.suppressed_emails
    suppressed_emails.include?(email)
  end
end
