class SharedsController < PostsController
  def index
     @shareds = Shared.all
   end

   def new
     @shared = Shared.new
   end

   def create
     @shared = Shared.new(params[:shared])
     @shared.user_id = current_user.id

     respond_to do |format|
       if @shared.save
         format.html { redirect_to(@shared, :notice => 'recipe was successfully created.') }
         format.xml  { render :xml => @shared, :status => :created, :location => @recipe }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @shared.errors, :status => :unprocessable_entity }
       end
     end
   end

   def show
     @shared = Shared.find(params[:id])
     @comment = Comment.new
     @comments = @shared.comments
   end

   def edit
     @shared = Shared.find(params[:id])
   end
end
