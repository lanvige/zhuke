class UserMailer < BaseMailer

  def registration_confirmation(user)
    @title = "Welcometo Zhuke"
    
    #https://github.com/plataformatec/devise/blob/master/app/mailers/devise/mailer.rb
    mail(:to => user.email, :subject => @title, :from => "zhuke.me@gmail.com")  
  end

end
