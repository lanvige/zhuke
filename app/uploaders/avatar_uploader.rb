class AvatarUploader < BaseUploader

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "avatar/#{version_name}.jpg"
  end

  # Create different versions of your uploaded files:
  version :thumb do
     process :resize_to_fit => [50, 50]
  end
  
  version :thumb_large do
    process :resize_to_fit => [100, 100]
  end

end
