class UserAccountMailer < ApplicationMailer
  def account_confirmation
    @user = params[:user]
    @url = params[:url]
    @role = params[:role]
    mail(to: @user.email, subject: "Account Confirmation")
  end
end