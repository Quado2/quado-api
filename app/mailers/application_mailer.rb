class ApplicationMailer < ActionMailer::Base
  default from: "verify@quado.dev"
  layout "mailer"
end
