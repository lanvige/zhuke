class RecipesController < PostsController
  
  def index
    @recipes = Recipe.all
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user_id = current_user.id
    
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to(@recipe, :notice => 'recipe was successfully created.') }
        format.xml  { render :xml => @recipe, :status => :created, :location => @recipe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @recipe = Recipe.find(params[:id])
    @comments = @recipe.comments
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    
    @recipe.update_attributes(params[:recipe])
  end
  
  def destory
    @recipe = Recipe.find(params[:id])
    @recipe.destory
  end
  
  def share
    @shared = Shared.new(params[:shared])
    #@content = Content.find(params[:id])
    #@shared.content_id = params[:id]
    
    @post = Post.find(params[:id])
    @shared.post = @post
    @shared.user_id = current_user.id
    
    respond_to do |format|
      if @shared.save
        format.html
        format.js
      else
        format.html
        format.xml
      end
    end
  end
end
