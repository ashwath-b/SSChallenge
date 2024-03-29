class UserController < ApplicationController

  def index
    @users = User.all
    @confirmed_users = @users.where(:confirmation_token => nil)
    @unconfirmed_users = @users.where('confirmation_token is not ?', nil)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if MailgunWebhook.is_valid_email(@user.email) && @user.save
      @user.update_attribute(:valid_email => true)
      MailgunTask.activation_email(@user.id)
      flash[:success] = "Please confirm your email address to continue"
    else
      flash[:error] = "Ooooppss, something went wrong!"
    end
    render 'new'
  end

  def confirm_email
    user = User.find_by_confirmation_token(params[:confirmation_token])
    if user
      user.email_activate
      flash[:success] = "Welcome, Your email has been confirmed."
    end
    # redirect_to root_url
  end

  private
  def user_params
		params.require(:user).permit(:email)
	end
end
