require 'rails_helper'

RSpec.describe ArticlesController, type: :routing do
  it 'routes "/" to articles#index' do
    expect(get('/')).to route_to('articles#index')
  end
  
  it 'routes "/articles" to "articles#index"' do
    expect(get('/articles')).to route_to('articles#index')
  end
  
  it 'routes "/articles/:id" should route to "articles#show"' do
    expect(get('/articles/1')).to route_to('articles#show', id: '1')
  end
  
  it 'routes "/feed" should route to "articles#feed"' do
    expect(get('/feed')).to route_to('articles#feed', format: 'rss')
  end
end