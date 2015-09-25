desc "Migrate CKEditor assets to another uploads folder"
task migrate_ckeditor_assets: [:environment] do
  Article.all.each do |article|
    article.body.gsub!("ckeditor_assets", "uploads")
    article.preview.gsub!("ckeditor_assets", "uploads")
    article.save
  end
end