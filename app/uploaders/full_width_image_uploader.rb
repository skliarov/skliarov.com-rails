# encoding: utf-8

class FullWidthImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  storage :file
  
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end
  
  # Process files as they are uploaded:
  process resize_to_limit: [800, 800]
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end