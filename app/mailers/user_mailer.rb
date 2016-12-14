class UserMailer < ActionMailer::Base
  default from: "'UserActivationApp' from@example.com"

  def registration_confirmation(user_id)
		@user = User.find(user_id)
		mail(to: @user.email, subject: 'Activate your account')
  end

  def activation_reminder(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Waiting for activation from you')
  end
end
