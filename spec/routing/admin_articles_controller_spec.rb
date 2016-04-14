require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :routing do
  context 'RESTful CRUD' do
    it 'routes GET "/admin/articles" to "admin/articles#index"' do
      expect(get('/admin/articles')).to route_to('admin/articles#index')
    end
    it 'routes GET "/admin/articles/:slug" to "admin/articles#show"' do
      expect(get('/admin/articles/text-slug')).to route_to('admin/articles#show', slug: 'text-slug')
    end
    it 'routes GET "/admin/articles/new" to "admin/articles#new"' do
      expect(get('/admin/articles/new')).to route_to('admin/articles#new')
    end
    it 'routes GET "/admin/articles/:slug/edit" to "admin/articles#edit"' do
      expect(get('/admin/articles/text-slug/edit')).to route_to('admin/articles#edit', slug: 'text-slug')
    end
    it 'routes POST "/admin/articles" to "admin/articles#create"' do
      expect(post('/admin/articles')).to route_to('admin/articles#create')
    end
    it 'routes PUT/PATCH "/admin/articles/:slug" to "admin/articles#update"' do
      expect(put('/admin/articles/text-slug')).to route_to('admin/articles#update', slug: 'text-slug')
      expect(patch('/admin/articles/text-slug')).to route_to('admin/articles#update', slug: 'text-slug')
    end
    it 'routes DELETE "/admin/articles/:slug" to "admin/articles#destroy"' do
      expect(delete('/admin/articles/text-slug')).to route_to('admin/articles#destroy', slug: 'text-slug')
    end
  end
  
  context 'custom routes' do
    it 'routes POST "/admin/articles/:slug/publish" to "admin/articles#publish"' do
      expect(post('/admin/articles/text-slug/publish')).to route_to('admin/articles#publish', slug: 'text-slug')
    end
    it 'routes POST "/admin/articles/sort" to "admin/articles#sort"' do
      expect(post('/admin/articles/sort')).to route_to('admin/articles#sort')
    end
  end
end