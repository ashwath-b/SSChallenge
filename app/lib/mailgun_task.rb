module MailgunTask

  # extend ActiveModel::Conern
  # default from: "'UserActivation' from@example.com"

  def self.activation_email(id)
    UserMailer.registration_confirmation(id).deliver
  end

  def self.activation_reminder
    @users = User.where(created_at: DateTime.now-3.days..DateTime.now-2.days)
    @users.each do |user|
      UserMailer.registration_confirmation(id).deliver
    end
  end

  def self.email_history

  end

  def self.suppression_list
    suppressed_email_list = MailgunWebhook.suppressed_emails

  end
end
