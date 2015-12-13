require 'rails_helper'

RSpec.describe ArticlesController, type: :routing do
  context 'root route' do
    it 'routes GET "/" to articles#index' do
      expect(get('/')).to route_to('articles#index')
    end
  end
  
  context 'RESTful CRUD' do
    it 'routes GET "/articles" to "articles#index"' do
      expect(get('/articles')).to route_to('articles#index')
    end
    it 'routes GET "/articles/:id" should route to "articles#show"' do
      expect(get('/articles/1')).to route_to('articles#show', id: '1')
    end
  end
  
  context 'custom routes' do
    it 'routes GET "/feed" should route to "articles#feed"' do
      expect(get('/feed')).to route_to('articles#feed', format: 'rss')
    end
  end
end