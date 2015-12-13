require 'rails_helper'

RSpec.describe PagesController, type: :routing do
  it 'routes "/portfolio" to "pages#portfolio"' do
    expect(get('/portfolio')).to route_to('pages#portfolio')
  end
  
  it 'routes "/about" to "pages#about"' do
    expect(get('/about')).to route_to('pages#about')
  end
  
  it 'routes "/contacts" to "pages#contacts"' do
    expect(get('/contacts')).to route_to('pages#contacts')
  end
end