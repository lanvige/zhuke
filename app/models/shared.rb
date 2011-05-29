class Shared < Post
  
  belongs_to :user
  belongs_to :post
  field :content
  
end
