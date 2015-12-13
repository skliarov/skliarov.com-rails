require 'rails_helper'

RSpec.describe 'Routes for Admin::ArticlesController', type: :routing do
  context 'RESTful CRUD' do
    it 'routes GET "/admin/articles" to "admin/articles#index"' do
      expect(get('/admin/articles')).to route_to('admin/articles#index')
    end
    it 'routes GET "/admin/articles/1" to "admin/articles#show"' do
      expect(get('/admin/articles/1')).to route_to('admin/articles#show', id: '1')
    end
    it 'routes GET "/admin/articles/new" to "admin/articles#new"' do
      expect(get('/admin/articles/new')).to route_to('admin/articles#new')
    end
    it 'routes GET "/admin/articles/1/edit" to "admin/articles#edit"' do
      expect(get('/admin/articles/1/edit')).to route_to('admin/articles#edit', id: '1')
    end
    it 'routes POST "/admin/articles" to "admin/articles#create"' do
      expect(post('/admin/articles')).to route_to('admin/articles#create')
    end
    it 'routes PUT/PATCH "/admin/articles/1" to "admin/articles#update"' do
      expect(put('/admin/articles/1')).to route_to('admin/articles#update', id: '1')
      expect(patch('/admin/articles/1')).to route_to('admin/articles#update', id: '1')
    end
    it 'routes DELETE "/admin/articles/1" to "admin/articles#destroy"' do
      expect(delete('/admin/articles/1')).to route_to('admin/articles#destroy', id: '1')
    end
  end
  
  context 'custom routes' do
    it 'routes POST "/admin/articles/1/publish" to "admin/articles#publish"' do
      expect(post('/admin/articles/1/publish')).to route_to('admin/articles#publish', id: '1')
    end
    it 'routes POST "/admin/articles/sort" to "admin/articles#sort"' do
      expect(post('/admin/articles/sort')).to route_to('admin/articles#sort')
    end
  end
end