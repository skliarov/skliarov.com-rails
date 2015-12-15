require 'factory_girl_rails'
require 'faker'

# Delete all articles
Article.destroy_all

# Create 100 new Articles
for i in 0..100
  article = FactoryGirl.build(:article)
  article.user = User.first
  article.published = true
  article.save
end