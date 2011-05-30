class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, :inverse_of => :posts
  
  embeds_many :comments
  
  # The content has been shards.
  has_many :shards
end