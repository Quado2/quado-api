class UserMailer < ApplicationMailer
  default from: 'hello@quado.dev'

  def verify_email
    @user = params[:user]
    @url = params[:url]
    @role = params[:role]
    mail(
      from: 'verify@quado.dev',
      to: @user.email, 
      subject: 'Welcome to my website ')
  end
end
