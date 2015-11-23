Ckeditor.setup do |config|
  # ORM configuration
  require "ckeditor/orm/active_record"
  
  # Allowed image file types for upload
  # Set to nil or [] (empty array) for all file types
  # By default: %w(jpg jpeg png gif tiff)
  config.image_file_types = ['jpg', 'jpeg', 'png', 'gif', 'tiff']
  
  # Allowed attachment file types for upload
  # Set to nil or [] (empty array) for all file types
  # By default: %w(doc docx xls odt ods pdf rar zip tar tar.gz swf)
  config.attachment_file_types = nil
  
  # Asset model classes
  config.picture_model { Ckeditor::Picture }
  config.attachment_file_model { Ckeditor::AttachmentFile }
  
  # Paginate assets
  # By default: 24
  config.default_per_page = 30
  
  # Customize ckeditor assets path
  # By default: nil
  # config.asset_path = "http://www.example.com/assets/ckeditor/"
  
  # To reduce the asset precompilation time, you can limit plugins and/or languages to those you need:
  # By default: nil (no limit)
  # config.assets_languages = ['en']
  # config.assets_plugins = ['image']
end