class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :confirmable, :omniauthable

  # field
  field :name
  field :email
  field :avatar
  field :bio
  field :website
  
  # define the slug for mongoid_slug
  slug :name
  
  mount_uploader :avatar, AvatarUploader
  
  validates_presence_of :name
  validates_format_of :name, :with => /\A[A-Za-z0-9_]+\z/
  validates_length_of :name, :maximum => 32
  validates_uniqueness_of :name, :email, :case_sensitive => false
  
  attr_accessor  :password_confirmation
  attr_accessible :name, :email, :password, :avatar, :password_confirmation, :remember_me
  
  # OmniAuth
  embeds_many :authorizations
  
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
  
  # devise confirm! method overriden
  def confirm!
    welcome_message
    super
  end
  
  # Create OmniAuth
  def self.create_from_hash(omniauth)  
    user = User.new
    user.name = omniauth["user_info"]["name"]
    Rails.logger.info user.name
    user.email = 'lanvige@126.com'
    Rails.logger.info user.email
    if user.email.blank?
      Rails.logger.error "Worng email infomation!"
      #return user
    end
    if( user.save )
      Rails.logger.info 'user saved!!!!!!!!!'
    else
      Rails.logger.info user.errors
    end
    
    user
  end
  
private

  def welcome_message
    UserMailer.registration_confirmation(self).deliver
  end
end

