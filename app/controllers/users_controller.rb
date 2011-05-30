#require 'carrierwave/orm/mongoid'

class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :public]

  def index
    @users = User.all
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find_by_slug(params[:id])
    puts @user.username
    
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
