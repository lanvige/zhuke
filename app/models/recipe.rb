class Recipe < Post
  field :title
  field :description
  field :picture
  field :material
  field :step
  #field :status
  #field :public
  #field :slug
  
  #mount_uploader :picture, RecipeUploader
    
end