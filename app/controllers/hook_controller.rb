class HookController < ApplicationController

  require 'csv'

  skip_before_filter  :verify_authenticity_token
  before_filter :verify_mailgun

  def bounce
    CsvWrite.write_csv(params[:recipient], params[:ip], params[:subject], params[:type])
    render nothing: true
  end

  def unsubscribe
    p params[:recipient]
    render nothing: true
  end

  def complaint
    p params[:recipient]
    render nothing: true
  end

  def click
    CsvWrite.write_csv(params[:recipient], params[:ip], params[:subject], params[:type])
    render nothing: true
  end

  private
  def verify_mailgun
    result = MailgunWebhook.verify_authenticity("key-34dc300a327bc5bb51e1351d017a8726", params[:token], params[:timestamp], params[:signature])
    unless !result
      return false
    end
  end
end
