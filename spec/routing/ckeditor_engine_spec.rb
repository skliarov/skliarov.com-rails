require 'rails_helper'

RSpec.describe 'Routes for CKEditor engine', type: :routing do
  routes { Ckeditor::Engine.routes }
  
  context 'pictures' do
    it 'routes GET "/pictures" to "ckeditor/pictures#index"' do
      expect(get('/pictures')).to route_to('ckeditor/pictures#index')
    end
    it 'routes POST "/pictures" to "ckeditor/pictures#create"' do
      expect(post('/pictures')).to route_to('ckeditor/pictures#create')
    end
    it 'routes DELETE "/pictures" to "ckeditor/pictures#destroy"' do
      expect(delete('/pictures/1')).to route_to('ckeditor/pictures#destroy', id: '1')
    end
  end
  
  context 'attachment files' do
    it 'routes GET "/attachment_files" to "ckeditor/attachment_files#index"' do
      expect(get('/attachment_files')).to route_to('ckeditor/attachment_files#index')
    end
    it 'routes POST "/attachment_files" to "ckeditor/attachment_files#create"' do
      expect(post('/attachment_files')).to route_to('ckeditor/attachment_files#create')
    end
    it 'routes DELETE "/attachment_files" to "ckeditor/attachment_files#destroy"' do
      expect(delete('/attachment_files/1')).to route_to('ckeditor/attachment_files#destroy', id: '1')
    end
  end
end