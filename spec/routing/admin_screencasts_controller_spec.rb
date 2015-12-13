require 'rails_helper'

RSpec.describe Admin::ScreencastsController, type: :routing do
  context 'RESTful CRUD' do
    it 'routes GET "/admin/screencasts/1" to "admin/screencasts#show"' do
      expect(get('/admin/screencasts/1')).to route_to('admin/screencasts#show', id: '1')
    end
    it 'routes GET "/admin/screencasts/1/edit" to "admin/screencasts#edit"' do
      expect(get('/admin/screencasts/1/edit')).to route_to('admin/screencasts#edit', id: '1')
    end
    it 'routes POST "/admin/screencasts" to "admin/screencasts#create"' do
      expect(post('/admin/screencasts')).to route_to('admin/screencasts#create')
    end
    it 'routes PUT/PATCH "/admin/screencasts/1" to "admin/screencasts#update"' do
      expect(put('/admin/screencasts/1')).to route_to('admin/screencasts#update', id: '1')
      expect(patch('/admin/screencasts/1')).to route_to('admin/screencasts#update', id: '1')
    end
    it 'routes DELETE "/admin/screencasts/1" to "admin/screencasts#destroy"' do
      expect(delete('/admin/screencasts/1')).to route_to('admin/screencasts#destroy', id: '1')
    end
  end
  
  context 'nested resources' do
    context 'lessons' do
      it 'routes GET "/admin/screencasts/1/lessons/new" to "admin/lessons#new"' do
        expect(get('/admin/screencasts/1/lessons/new')).to route_to('admin/lessons#new', screencast_id: '1')
      end
    end
  end
  
  context 'custom routes' do
    it 'routes POST "/admin/screencasts/sort" to "admin/screencasts#sort"' do
      expect(post('/admin/screencasts/sort')).to route_to('admin/screencasts#sort')
    end
  end
end