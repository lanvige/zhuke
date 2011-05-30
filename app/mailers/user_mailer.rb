class UserMailer < ActionMailer::Base
  default :from => "zhuke.me@gmail.com"  
  
  def registration_confirmation(user)  
    mail(:to => user.email, :subject => "Registered", :from => "zhuke.me@gmail.me")  
  end
end
