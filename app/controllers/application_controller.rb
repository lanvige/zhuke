class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Replace example.org with your actual domain name
  #def mailer_set_url_options
  #  ActionMailer::Base.default_url_options[:host] = request.host_with_port
  #end
end
