class HookController < ApplicationController

  require 'csv'

  skip_before_filter  :verify_authenticity_token
  before_filter :verify_mailgun

  def bounce
    CsvWrite.write_csv(params[:recipient], params[:ip], params[:subject], params[:type])
    user = User.where(:email => params[:recipient])
    user.update_attribute(:valid_email => false) if user.present?
    render nothing: true
  end

  def unsubscribe
    # p params[:recipient]
    user = User.where(:email => params[:recipient])
    user.update_attribute(:valid_email => false) if user.present?
    render nothing: true
  end

  def complaint
    # p params[:recipient]
    user = User.where(:email => params[:recipient])
    user.update_attribute(:valid_email => false) if user.present?
    render nothing: true
  end

  def click
    CsvWrite.write_csv(params[:recipient], params[:ip], params[:subject], params[:type])
    render nothing: true
  end

  private
  def verify_mailgun
    result = MailgunWebhook.verify_authenticity(ENV['mailgun-api-key'], params[:token], params[:timestamp], params[:signature])
    unless !result
      return false
    end
  end
end
