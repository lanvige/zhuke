class Content
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, :inverse_of => :contents
  
  has_many :comments
  
  # The content has been shards.
  has_many :shards
end