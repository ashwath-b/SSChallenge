class User < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX } , uniqueness: { case_sensitive:false }
  before_create :generate_token

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def validate_email
    result = RestClient.get "https://api:pubkey-b45f050b03c1dd167a39a933dcc5a15a@api.mailgun.net/v3/address/validate?#{self.email}"
    result["is_valid"] == true
  end

  private
  def generate_token
    if self.confirmation_token.blank?
      self.confirmation_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end
