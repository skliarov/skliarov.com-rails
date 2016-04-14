require 'rails_helper'

RSpec.describe PagesController, type: :routing do
  context 'custom routes' do
    it 'routes GET "/" to "pages#about"' do
      expect(get('/')).to route_to('pages#about')
    end
  end
end