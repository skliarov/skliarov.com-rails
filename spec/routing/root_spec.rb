require 'rails_helper'

RSpec.describe 'Root route', type: :routing do
  it 'root should route to articles#index' do
    expect(get('/')).to route_to('articles#index')
  end
end