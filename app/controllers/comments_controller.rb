class CommentsController < ApplicationController
  
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def new
    @content = Content.find(params[:recipe_id])
    @comment = @content.comments.build
  end

  def edit
  end

  # POST /comments
  # POST /comments.xml
  def create
    @content = Content.find(params[:recipe_id])
    @comment = @content.comments.build(params[:comment])

    if @comment.save
      respond_to do |format|
        format.html { redirect_to(@recipe, :notice => 'Comment was successfully created.') }
        format.js
      end
    else
      render :new
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
  
private
  def find_text
    @text = Recipe.find(params[:text_id])
  end

  def find_or_build_comment
    @comment = params[:id] ? @text.comments.find(params[:id]) : @text.comments.build(params[:comment])
  end
end
