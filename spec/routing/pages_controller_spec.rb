require 'rails_helper'

RSpec.describe PagesController, type: :routing do
  context 'custom routes' do
    it 'routes GET "/portfolio" to "pages#portfolio"' do
      expect(get('/portfolio')).to route_to('pages#portfolio')
    end
    it 'routes GET "/about" to "pages#about"' do
      expect(get('/about')).to route_to('pages#about')
    end
    it 'routes GET "/contacts" to "pages#contacts"' do
      expect(get('/contacts')).to route_to('pages#contacts')
    end
  end
end