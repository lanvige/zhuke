class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :content

  belongs_to :user
  belongs_to :post
end
