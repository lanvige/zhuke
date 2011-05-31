#require 'carrierwave/orm/mongoid'

class UsersController < ApplicationController
  #before_filter :authenticate_user!, :except => [:new, :create, :public]
  skip_before_filter :verify_authenticity_token, :only => [:auth_callback]
  
  def index
    @users = User.all
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find_by_slug(params[:id])
    puts @user.name
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_path, :notice => 'User Update Successful') }
        format.json
      else
        format.html { render :action => "edit" }
        format.json
      end
    end
  end
  
  def show
    @user = User.find_by_slug(params[:id])
    @posts = @user.posts.all
  end

  # omniauth callback method 
  def omniauth_callbacks
    omniauth = request.env['omniauth.auth']
    redirect_to root_path if omniauth.blank?
    Rails.logger.debug "omniauth1111111111111111111111......"
    
    
    if current_user
      # Binding the auth to current account.
      Authorization.create_from_hash(omniauth, current_user)
      flash[:notice] = "Success binding"
      redirect_to edit_user_registration_path
    elsif @user = Authorization.find_from_hash(omniauth)
      sign_in @user
      flash[:notice] = "Login success"
      redirect_to "/"
    else
      Rails.logger.debug "omniauth11111111111111111111112222......"
      @new_user = Authorization.create_from_hash(omniauth, current_user) #Create a new user
      if @new_user.errors.blank?
        sign_in @new_user
        flash[:notice] = "Welcome"
        Rails.logger.debug { "omniauth2" + @new_user.name }
        redirect_to "/"
      else
        flash[:notice] = "Account Issue"
        redirect_to "/register"
      end
    end
  end

  # Omniauth failure callback
  def auth_failure
    flash[:notice] = params[:message]
    redirect_to root_path
  end

  # logout - Clear our rack session BUT essentially redirect to the provider
  # to clean up the Devise session from there too !
  def destroy
    session[:user_id] = nil

    flash[:notice] = 'You have successfully signed out!'
    redirect_to "#{CUSTOM_PROVIDER_URL}/users/sign_out"
  end
  
    
  def follow
    @user = User.find_by_slug(params[:id])
    if @user
      current_user.follow(@user)
    else
      puts @user.id
    end
  end
  
  def unfollow
    @user = User.find_by_slug(params[:id])
    if not @user
      render :text => "0"
      return
    end
    current_user.unfollow(@user)
    render :text => "1"
  end
  
  def following
    @user = User.find_by_slug(params[:id])
    @following = @user.following
    
    if params[:format] == "js"
      render "following.js"
    else
      render "following"
    end
  end
  
  def followers
    @user = User.find_by_slug(params[:id])
    @per_page = 10
    @followers = @user.followers
    
    if params[:format] == "js"
      render "followers.js"
    else
      render "followers"
    end
  end
end
