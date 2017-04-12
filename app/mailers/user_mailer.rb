class UserMailer < ApplicationMailer
  default from: 'noreply@cfapp-totally-fake.com'

  def contact_form(email, name, message)
    @message = message
    mail(from: email,
         to: ENV['EMAIL_ADDRESS'],
         subject: "A new contact form message from #{name}")
  end

  def welcome(user)
    @appname = 'Bicycle Berlin'
    mail(to: user.email,
         subject: "Welcome to #{@appname}!")
  end
end
