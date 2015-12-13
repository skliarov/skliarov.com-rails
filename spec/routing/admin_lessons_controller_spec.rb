require 'rails_helper'

RSpec.describe Admin::LessonsController, type: :routing do
  context 'RESTful CRUD' do
    it 'routes GET "/admin/lessons/1" to "admin/lessons#show"' do
      expect(get('/admin/lessons/1')).to route_to('admin/lessons#show', id: '1')
    end
    it 'routes GET "/admin/lessons/new" to "admin/lessons#new"' do
      expect(get('/admin/lessons/new')).to route_to('admin/lessons#new')
    end
    it 'routes GET "/admin/lessons/1/edit" to "admin/lessons#edit"' do
      expect(get('/admin/lessons/1/edit')).to route_to('admin/lessons#edit', id: '1')
    end
    it 'routes POST "/admin/lessons" to "admin/lessons#create"' do
      expect(post('/admin/lessons')).to route_to('admin/lessons#create')
    end
    it 'routes PUT/PATCH "/admin/lessons/1" to "admin/lessons#update"' do
      expect(put('/admin/lessons/1')).to route_to('admin/lessons#update', id: '1')
      expect(patch('/admin/lessons/1')).to route_to('admin/lessons#update', id: '1')
    end
    it 'routes DELETE "/admin/lessons/1" to "admin/lessons#destroy"' do
      expect(delete('/admin/lessons/1')).to route_to('admin/lessons#destroy', id: '1')
    end
  end
  
  context 'custom routes' do
    it 'routes POST "/admin/lessons/sort" to "admin/lessons#sort"' do
      expect(post('/admin/lessons/sort')).to route_to('admin/lessons#sort')
    end
  end
end