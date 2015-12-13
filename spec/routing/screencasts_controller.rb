require 'rails_helper'

RSpec.describe 'Routes for ScreencastsController', type: :routing do
  context 'RESTful CRUD' do
    it 'routes GET "/screencasts" to "screencasts#index"' do
      expect(get('/screencasts')).to route_to('screencasts#index')
    end
    it 'routes GET "/screencasts/:id" should route to "screencasts#show"' do
      expect(get('/screencasts/1')).to route_to('screencasts#show', id: '1')
    end
  end
end