class SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    Rails.logger.debug { "omniauth1:::::::" }
    Rails.logger.info "My info message"
    puts 'omniauth1:11111111111111111111111111111111::::::'
    
    # render :new, :layout => 'login'
    super
    
  end

  # POST /resource/sign_in
  def create
    super
  end

  # GET /resource/sign_out
  def destroy
    super
  end
end