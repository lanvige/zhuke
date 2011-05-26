class ContentsController < ApplicationController
  
  before_filter :authenticate_user!
  
end
