class UserMailer < BaseMailer

  def registration_confirmation(user)
    @title = "欢迎加入[#{Setting.app_name}]"
    
    #https://github.com/plataformatec/devise/blob/master/app/mailers/devise/mailer.rb
    mail(:to => user.email, :subject => @title, :from => Setting.email_sender)  
  end

end
