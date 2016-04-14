require 'rails_helper'

RSpec.describe ArticlesController, type: :routing do
  context 'RESTful CRUD' do
    it 'routes GET "/articles" to "articles#index"' do
      expect(get('/articles')).to route_to('articles#index')
    end
    it 'routes GET "/articles/:slug" should route to "articles#show"' do
      expect(get('/articles/text-slug')).to route_to('articles#show', slug: 'text-slug')
    end
  end
  
  context 'custom routes' do
    it 'routes GET "/feed" should route to "articles#feed"' do
      expect(get('/feed')).to route_to('articles#feed', format: 'rss')
    end
  end
end