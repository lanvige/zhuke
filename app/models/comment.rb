class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :con

  belongs_to :content
end
