class RecipeUploader < BaseUploader

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "recipe/#{version_name}.jpg"
  end

  # Create different versions of your uploaded files:
  version :thumb do
     process :resize_to_fit => [128, 82]
  end
  
  version :fit do
    process :resize_to_fit => [525, 394]
  end

end
