require 'rails_helper'

RSpec.describe 'Routes for Admin::ChaptersController', type: :routing do
  context 'RESTful CRUD' do
    it 'routes GET "/admin/chapters" to "admin/chapters#index"' do
      expect(get('/admin/chapters')).to route_to('admin/chapters#index')
    end
    it 'routes GET "/admin/chapters/1" to "admin/chapters#show"' do
      expect(get('/admin/chapters/1')).to route_to('admin/chapters#show', id: '1')
    end
    it 'routes GET "/admin/chapters/new" to "admin/chapters#new"' do
      expect(get('/admin/chapters/new')).to route_to('admin/chapters#new')
    end
    it 'routes GET "/admin/chapters/1/edit" to "admin/chapters#edit"' do
      expect(get('/admin/chapters/1/edit')).to route_to('admin/chapters#edit', id: '1')
    end
    it 'routes POST "/admin/chapters" to "admin/chapters#create"' do
      expect(post('/admin/chapters')).to route_to('admin/chapters#create')
    end
    it 'routes PUT/PATCH "/admin/chapters/1" to "admin/chapters#update"' do
      expect(put('/admin/chapters/1')).to route_to('admin/chapters#update', id: '1')
      expect(patch('/admin/chapters/1')).to route_to('admin/chapters#update', id: '1')
    end
    it 'routes DELETE "/admin/chapters/1" to "admin/chapters#destroy"' do
      expect(delete('/admin/chapters/1')).to route_to('admin/chapters#destroy', id: '1')
    end
  end
  
  context 'nested resources' do
    context 'screencasts' do
      it 'routes GET "/admin/chapters/1/screencasts/new" to "admin/screencasts#new"' do
        expect(get('/admin/chapters/1/screencasts/new')).to route_to('admin/screencasts#new', chapter_id: '1')
      end
    end
  end
  
  context 'custom routes' do
    it 'routes POST "/admin/chapters/sort" to "admin/chapters#sort"' do
      expect(post('/admin/chapters/sort')).to route_to('admin/chapters#sort')
    end
  end
end