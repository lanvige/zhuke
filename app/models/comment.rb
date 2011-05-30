class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :content

  belongs_to :user
  embedded_in :post
end
