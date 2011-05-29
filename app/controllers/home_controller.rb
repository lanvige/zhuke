class HomeController < ApplicationController
  def index
    if(current_user)
      @user = current_user
      @posts = Post.any_of( {:user_id.in => current_user.following_ids}).any_of({ :user_id => current_user.id}).desc(:created_at)
    end
  end
end