class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  # field
  field :username
  field :email
  field :avatar
  field :bio
  field :website
  
  # define the slug for mongoid_slug
  slug :username
  
  mount_uploader :avatar, AvatarUploader
  
  validates_presence_of :username
  validates_format_of :username, :with => /\A[A-Za-z0-9_]+\z/
  validates_length_of :username, :maximum => 32
  validates_uniqueness_of :username, :email, :case_sensitive => false
  
  attr_accessor  :password_confirmation
  attr_accessible :username, :email, :password, :avatar, :password_confirmation, :remember_me
  
  # embed
  has_many :posts, :class_name => "Post"
  has_many :comments, :class_name => "Comment"
  
  
  # Socical
  references_and_referenced_in_many :following, :class_name => 'User', :inverse_of => :followers, :index => true, :stored_as => :array
  references_and_referenced_in_many :followers, :class_name => 'User', :inverse_of => :following, :index => true, :stored_as => :array
  
  def followed?(user)
    self.following.include?(user)
  end
  
  def follow(user)
    user.followers << self
    user.save
  end
  
  def unfollow(user)
    self.following.delete(user)
    self.save
    
    user.followers.delete(self)
    user.save
  end
end

