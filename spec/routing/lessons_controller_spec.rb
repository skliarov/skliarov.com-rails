require 'rails_helper'

RSpec.describe 'Routes for LessonsController', type: :routing do
  context 'RESTful CRUD' do
    it 'routes GET "/screencasts/:screencast_id/lessons/:id" should route to "lessons#show"' do
      expect(get('/screencasts/1/lessons/2')).to route_to('lessons#show', screencast_id: '1', id: '2')
    end
  end
end